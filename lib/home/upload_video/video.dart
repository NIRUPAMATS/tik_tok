import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String? userId;
  String? userName;
  String? userProfileImage;
  String? videoId;
  int? totalComments;
  int? totalShares;
  List? likesList;
  String? artistSongName;
  String? videoUrl;
  String? descriptionTags;
  String? thumbnailUrl;
  int? publishedDAteTime;

  Video({
    this.userId,
    this.userName,
    this.userProfileImage,
    this.videoId,
    this.totalComments,
    this.totalShares,
    this.likesList,
    this.artistSongName,
    this.videoUrl,
    this.descriptionTags,
    this.thumbnailUrl,
    this.publishedDAteTime,
  });
  Map<String,dynamic> toJson()=>{
    'userId':userId,
    'userName':userName,
    'userProfileImage':userProfileImage,
    'videoId':videoId,
    'totalComments':totalComments,
    'totalShares':totalShares,
    'likesList':likesList,
    'artistSongName':artistSongName,
    'videoUrl':videoUrl,
    'descriptionTags':descriptionTags,
    'thumbnailUrl':thumbnailUrl,
    'publishedDAteTime':publishedDAteTime,
  };

  static Video fromDocumentSnapshot(DocumentSnapshot snapshot){
    var docSnapshot=snapshot.data() as Map<String,dynamic>;
    return Video(
      userId:docSnapshot['userId'],
      userName:docSnapshot['userName'],
      userProfileImage:docSnapshot['userProfileImage'],
      videoId:docSnapshot['videoId'],
      totalComments:docSnapshot['totalComments'],
      totalShares:docSnapshot['totalShares'],
      likesList:docSnapshot['likesList'],
      artistSongName:docSnapshot['artistSongName'],
      videoUrl:docSnapshot['videoUrl'],
      descriptionTags:docSnapshot['descriptionTags'],
      thumbnailUrl:docSnapshot['thumbnailUrl'],
      publishedDAteTime:docSnapshot['publishedDAteTime'],

    );
  }
}