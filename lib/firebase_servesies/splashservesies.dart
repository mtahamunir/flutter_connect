import 'dart:async';
import 'package:firebase_connect/auth/login.dart';
import 'package:get/get.dart';

class Splashservesies{

  isLogin(){
    Timer.periodic(Duration(seconds: 3), (timer) {
        Get.off(LoginScreen());
     });
  }
}