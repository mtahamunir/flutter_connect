import 'package:firebase_connect/home/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDate extends StatefulWidget {
  const UpdateDate({super.key});

  @override
  State<UpdateDate> createState() => _UpdateDateState();
}

class _UpdateDateState extends State<UpdateDate> {
  TextEditingController Updatedata = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Updatedata'),
        ),
        body: Column(
          children: [
            TextField(
                controller: Updatedata
                  ..text = Get.arguments['note'].toString()),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('notes')
                      .doc(Get.arguments['docId'].toString())
                      .update({'note': Updatedata.text.trim()}).then((value) {
                    Get.offAll(Welcome());
                    Get.snackbar("Note CHanged" ,'' );
                  });
                },
                child: Text('Update'))
          ],
        ));
  }
}
