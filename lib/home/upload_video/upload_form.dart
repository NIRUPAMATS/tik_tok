import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:vid_upload/home/upload_video/upload_controller.dart';
import 'package:video_player/video_player.dart';

import '../../global.dart';
import '../../widgets/input_text_widget.dart';
class UploadForm extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  UploadForm({required this.videoFile, required this.videoPath}) ;

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  UploadController uploadVideoController=Get.put(UploadController());

  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController=TextEditingController();
  TextEditingController descriptionTextEditingController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      playerController=VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController!.dispose();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //videoplayer
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,
              child: VideoPlayer(playerController!),
            ),
            const SizedBox(height: 30,),
            //upload button
            //circular Progress bar
            //input fileds
            showProgressBar==true
                ? Container(
                  child: const SimpleCircularProgressBar(
                    size: 50,
                    backStrokeWidth: 0,
                    progressStrokeWidth: 10,
                    progressColors: [
                      Colors.lightGreenAccent,
                      Colors.lightBlueAccent,
                      Colors.pinkAccent,
                      Colors.yellowAccent,
                      Colors.greenAccent
                    ],
                    animationDuration: 2,
                    backColor: Colors.white38,
                   ),
                )
                :Column(
                  children: [
                    //artist song
                    Container(
                      width: MediaQuery.of(context).size.width-20,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputTextWidget(
                        textEditingController: artistSongTextEditingController,
                        labelString: 'Artist song',
                        iconData: Icons.music_video_sharp,
                        isObscure: true,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    //desc tags
                    Container(
                      width: MediaQuery.of(context).size.width-20,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputTextWidget(
                        textEditingController: descriptionTextEditingController,
                        labelString: 'Description Tags',
                        iconData: Icons.slideshow_sharp,
                        isObscure: true,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    //upload now
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      ),
                      child:InkWell(
                        onTap: (){
                          if(artistSongTextEditingController.text.isNotEmpty &&descriptionTextEditingController.text.isNotEmpty){
                              uploadVideoController.saveVideoInformationToFirestoreDatabase(artistSongTextEditingController.text, descriptionTextEditingController.text, widget.videoPath, context);
                              setState(() {
                                showProgressBar=true;
                              });
                          }

                        },
                        child: const Center(
                          child: Text('Upload Now',
                            style: TextStyle(
                              fontSize:20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ) ,
                    ),
                    const SizedBox(height: 20,),

                  ],
                ),


          ],
        ),
      ),

    );
  }
}
