import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:vid_upload/authentication/login_screen.dart';
import '../global.dart';
import '../widgets/input_text_widget.dart';
import 'authentication_controller.dart';
class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();


  var authenticationController=AuthenticationController.instanceAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
          child: Center(
            child:Column(
              children: [
                SizedBox(height: 100,),
                Text('Create Account',
                  style: GoogleFonts.acme(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
                Text('To get started now!',
                  style: GoogleFonts.shadowsIntoLight(
                      fontSize: 24,
                      color: Colors.grey
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    authenticationController.chooseImagefromGallery();
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage:AssetImage('images/profile.png') ,
                    backgroundColor: Colors.black,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: nameTextEditingController,
                    labelString: 'Name',
                    iconData: Icons.account_circle,
                    isObscure: false,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: emailTextEditingController,
                    labelString: 'Email',
                    iconData: Icons.email_outlined,
                    isObscure: false,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: passwordTextEditingController,
                    labelString: 'Password',
                    iconData: Icons.password_outlined,
                    isObscure: true,
                  ),
                ),
                SizedBox(height: 40,),
                showProgressBar ==false?
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                      ),
                      child:InkWell(
                        onTap: (){
                          setState(() {
                            showProgressBar=true;
                          });
                          if(authenticationController.profileImage !=null && nameTextEditingController.text !=null &&emailTextEditingController.text !=null &&passwordTextEditingController.text !=null) {
                            authenticationController.createAccountForNewUser(
                              authenticationController.profileImage!,
                              nameTextEditingController.text,
                              emailTextEditingController.text,
                              passwordTextEditingController.text,
                            );
                          }
                        },
                        child: const Center(
                          child: Text('Signup',
                            style: TextStyle(
                              fontSize:20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),),
                        ),
                      ) ,
                    ),
                    SizedBox(height: 14,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),),
                        InkWell(
                          onTap: (){
                            Get.to(LoginScreen());
                          },
                          child: const Text(' Login now',
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ):Container(
                  child: SimpleCircularProgressBar(
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
                    animationDuration: 1,
                    backColor: Colors.white30,
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
