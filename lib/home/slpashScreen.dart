import 'package:firebase_connect/firebase_servesies/splashservesies.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

// Splashservesies SplashScreen = Splashservesies();

  // @override
  // void initState() {
  //   super.initState();
  //   SplashScreen.isLogin();
  // }
  // Future <Timer>(){
  //   Duration(seconds: )
  // }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
                Center(child: Text('Weclome',style: TextStyle(fontSize: 40),)),
                SizedBox(height: 50,),
                CircularProgressIndicator()
      ],
    ),
    );
  }
}