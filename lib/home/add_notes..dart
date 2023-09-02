import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connect/home/welcome.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  User? userId = FirebaseAuth.instance.currentUser;
  TextEditingController notecontroller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add note'),
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'requied';
                  } else {
                    return null;
                  }
                },
                controller: notecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final isValidForm = formkey.currentState!.validate();
                    if (isValidForm) {
                      var note = notecontroller.text.trim();
                      await FirebaseFirestore.instance
                          .collection('notes')
                          .doc()
                          .set({
                        'note': note,
                        'created At': DateTime.now(),
                        'userId': userId?.uid
                      }).then((value) {
                        Get.snackbar('Note Saved', note);
                        Get.offAll(Welcome());
                      });
                    }
                    ;
                  },
                  child: Text('Add note'))
            ]),
          ),
        ),
      ),
    );
  }
}
