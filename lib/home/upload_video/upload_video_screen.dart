
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_upload/home/upload_video/upload_form.dart';
class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  getVideoFile(ImageSource sourceImg) async{
    final videoFile=await ImagePicker().pickVideo(source: sourceImg);
    if(videoFile!=null){
      Get.to(
        UploadForm(
          videoFile: File(videoFile.path),
          videoPath: videoFile.path,

        ),
      );
    }

  }

  displayDialogueBox() {
    return showDialog(
        context: context,
        builder: (context)=>SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: (){
                getVideoFile(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.image_outlined,
                  ),
                  Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Set video from gallery",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                getVideoFile(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("Get video with Phone camera",
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: (){
                Get.back();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.cancel_outlined,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Cancel",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/img1.png',width: 260,),
            const SizedBox(height: 40,),
            ElevatedButton(
                onPressed: (){
                  //display dialogue box
                  displayDialogueBox();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                child: const Text("Upload New Video",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
