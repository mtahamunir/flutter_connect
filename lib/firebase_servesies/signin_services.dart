
import 'package:firebase_connect/home/welcome.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

SigninUser(String username, String password) async{

  User? userid = FirebaseAuth.instance.currentUser;
  
   await FirebaseFirestore.instance
                              .collection("users")
                              .doc(userid!.uid,)
                              .set({
                            "username": username,
                            "password": password,
                            "createdAt":DateTime.now(),
                            "userId": userid.uid,
 }).then((value) {
  // FirebaseAuth.instance.signOut();
  Get.to(Welcome());
 });

}