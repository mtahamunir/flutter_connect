
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connect/auth/signin.dart';
// import 'package:firebase_connect/auth/signin.dart';
import 'package:firebase_connect/home/welcome.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            obscureText: _obscureText,            
            controller: passwordController,
            decoration: InputDecoration(
            
                hintText: 'Password',
                prefixIcon: Icon(Icons.key),
                suffixIcon: InkWell(
                  onTap:(){
                    setState(() {
                      
                    });
                    _obscureText = ! _obscureText;
                  },
                  child: Icon(Icons.remove_red_eye)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
          SizedBox(
            height: 12,
          ),
          
          InkWell(
              onTap: () {Get.to(SigninScreen());},
              child: Text("don't have an account")),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
              onPressed: () async{
                _auth.signInWithEmailAndPassword(
                  email: emailController.text.toString(), 
                  password: passwordController.text.toString()).then((value) {
                    Get.to(Welcome());
                    Get.snackbar('Login', 'succesfully');
                  }).onError((error, stackTrace) {
                    Get.snackbar("title", '$error');
                  });
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              )),
        ]),
      ),
    );
  }
}
