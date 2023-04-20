import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vid_upload/home/upload_video/video.dart';
import 'package:video_compress/video_compress.dart';

import '../../global.dart';
import '../home_screen.dart';


class UploadController extends GetxController{
  compressVideoFile(String videoFilePath) async{
   final compressedVideoFilePath= await VideoCompress.compressVideo(videoFilePath,quality: VideoQuality.MediumQuality);
   return compressedVideoFilePath!.file;
  }

  uploadCompressedVideoFileToFirebase(String videoId,String videoFilePath) async{
    UploadTask videoUploadTask=FirebaseStorage.instance.ref().child('All videos').child(videoId).putFile(await compressVideoFile(videoFilePath));
    TaskSnapshot snapshot=await videoUploadTask;
    String downloadUrlOfUploadedVideo= await snapshot.ref.getDownloadURL();
    return downloadUrlOfUploadedVideo;
  }

  getThumbnailImage(String videoFilePath)async{
    final thumbnailImage= await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;
  }
  uploadThumbnailImageFileToFirebase(String videoId,String videoFilePath) async{
    UploadTask thumbnailUploadTask=FirebaseStorage.instance.ref().child('All thumbnails').child(videoId).putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot=await thumbnailUploadTask;
    String downloadUrlOfUploadedThumbnail= await snapshot.ref.getDownloadURL();
    return downloadUrlOfUploadedThumbnail;
  }

  saveVideoInformationToFirestoreDatabase(String artistSongName,String descriptionTags ,String videoFilePath,BuildContext context)async{
    try{
      DocumentSnapshot userDocumentSnapshot=await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid).get();

      String videoId =DateTime.now().microsecondsSinceEpoch.toString();

      //1.upload vid to storage
      String videoDownloadUrl=await uploadCompressedVideoFileToFirebase(videoId, videoFilePath);

      //2.thumbnail
      String thumbnailDownloadUrl=await uploadThumbnailImageFileToFirebase(videoId, videoFilePath);

      //3.save overall vid into firestore database
       Video videoObject=Video(
         userId: FirebaseAuth.instance.currentUser!.uid,
         userName:(userDocumentSnapshot.data() as Map<String,dynamic>)['name'],
         userProfileImage:(userDocumentSnapshot.data() as Map<String,dynamic>)['image'],
         videoId: videoId,
         totalComments: 0,
         totalShares: 0,
         likesList: [],
         artistSongName: artistSongName,
         descriptionTags: descriptionTags,
         videoUrl: videoDownloadUrl,
         thumbnailUrl: thumbnailDownloadUrl,
         publishedDAteTime: DateTime.now().microsecondsSinceEpoch,
       );
       await FirebaseFirestore.instance.collection('videos').doc(videoId).set(videoObject.toJson());
       Get.to(HomecScreen());
       Get.snackbar('New Video', 'You have successfully uploaded');
       showProgressBar=false;
    }
    catch(error){
      Get.snackbar('Error', 'Upload unsuccessful!');
    }
  }
}