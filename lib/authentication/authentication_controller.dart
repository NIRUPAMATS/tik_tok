
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_upload/authentication/login_screen.dart';
import 'package:vid_upload/authentication/registeration_screen.dart';

import 'package:vid_upload/home/home_screen.dart';
import '../global.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController{

  //static AuthenticationController instanceAuth= Get.put(AuthenticationController());
  static AuthenticationController instanceAuth= Get.find();
  late Rx<User?> _currentUser;

  late Rx<File?> _pickedFile;

  File? get profileImage=> _pickedFile.value;
  void chooseImagefromGallery()async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar(
          "Progile Image",
          "You had successfully selected your profile image"
      );
    }
    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera()async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar(
          "Progile Image",
          "You had successfully captured your profile image with Phone camera"
      );
    }
    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(File imageFile,String userName,String userEmail,String userPassword)async{
    try{
      //1.create user in the firebase authentication
      UserCredential credential=await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      //2.save the user profile image to firebase storage
      String imageDownloadUrl=await uploadImageToStorage(imageFile);

      //3.save user data to the firestore database
      userModel.User user=userModel.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());
      Get.snackbar("Account created", 'Congratulations!');
      showProgressBar=false;

    }
    catch(error){
      Get.snackbar("Account creation unsuccessful", 'Error Occurred while creating account');

      showProgressBar=false;
      Get.to(LoginScreen());


    }
  }

  Future<String> uploadImageToStorage(File imageFile) async{
    Reference reference=FirebaseStorage.instance.ref()
        .child('Profile images')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot= await uploadTask;

    String downloadUrlOfUploadedImage = await taskSnapshot.ref.getDownloadURL();
    return downloadUrlOfUploadedImage;
  }

  void loginUserNow(String userEmail,String userPassword) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      Get.snackbar("Login successful", 'Congratulation!');

      showProgressBar=false;
    }
    catch(error){
      Get.snackbar("Login unsuccessful", 'Error Occurred while signin authentication!');

      showProgressBar=false;
      Get.to(RegisterationScreen());
    }

  }

  goToScreen(User? currentUser){
    if(currentUser==null){
      Get.offAll(LoginScreen());
    }
    else{
      Get.offAll(HomecScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _currentUser=Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}