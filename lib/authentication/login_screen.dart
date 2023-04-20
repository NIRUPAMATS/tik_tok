import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:vid_upload/authentication/registeration_screen.dart';


import '../widgets/input_text_widget.dart';
import 'authentication_controller.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  bool showProgressBar=false;
  var authenticationController=AuthenticationController.instanceAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            children: [
              SizedBox(height: 100,),
              Image.asset('images/img1.png',width: 200,height: 150,),
              Text('Welcome',
                style: GoogleFonts.acme(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              Text('Glad to see you!',
                style: GoogleFonts.shadowsIntoLight(
                    fontSize: 24,
                    color: Colors.grey
                ),
              ),
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
                        if(emailTextEditingController.text.isNotEmpty && passwordTextEditingController.text.isNotEmpty )
                        {
                          setState(() {
                            showProgressBar=true;
                          });
                          authenticationController.loginUserNow(
                            emailTextEditingController.text,
                            passwordTextEditingController.text,
                          );
                        }

                      },
                      child: const Center(
                        child: Text('Login',
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
                      const Text('Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),),
                      InkWell(
                        onTap: (){
                          Get.to(RegisterationScreen());
                        },
                        child: const Text(' Signup now!',
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
      )
    );
  }
}
