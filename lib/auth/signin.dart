import 'package:firebase_connect/auth/login.dart';
import 'package:firebase_connect/firebase_servesies/signin_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign IN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: userController,
            decoration: InputDecoration(
                hintText: 'User name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
          SizedBox(
            height: 12,
          ),
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
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(Icons.remove_red_eye)),
                hintText: 'Password',
                prefixIcon: Icon(Icons.key),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
          SizedBox(
            height: 12,
          ),
           InkWell(
            onTap: (){Get.to(LoginScreen());},
            child: Text('Already have an account')),
          
          SizedBox(
            height: 12,
          ),

          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
              onPressed: () async {
                var username = userController.text.trim();
                var password = passwordController.text.trim();
                await
                _auth
                    .createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) => {
                          // print('...................ated'),
                          SigninUser(username,password)
                          
                        });
              },
              child: Text(
                'Signin',
                style: TextStyle(fontSize: 20),
              )),
        ]),
      ),
    );
  }
}
