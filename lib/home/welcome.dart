// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connect/auth/login.dart';
import 'package:firebase_connect/home/add_notes..dart';
import 'package:firebase_connect/home/updatedata.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    sendDataToFireStore();
   }

  void sendDataToFireStore() {
    FirebaseFirestore.instance
        .collection('notes');
        // .orderBy('created At')
        // .add({'timestamp': FieldValue.serverTimestamp()});
  }

  var _numberToMouthMap = {
    1: "jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };
  

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('welcome'),
          actions: [
            InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.to(LoginScreen());
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Icon(
                    Icons.logout,
                  ),
                  
                ))
          ],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notes').orderBy('created At',descending: true)
                .where('userId', isEqualTo: userId?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something Wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Text("data not found");
              }

              // if(snapshot.)
              // ignore: unnecessary_null_comparison
              if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, Index) {
                      var note = snapshot.data!.docs[Index]['note'];
                      // var created =snapshot.data!.docs[Index]['created At'];
                      Timestamp t =
                          snapshot.data!.docs[Index]['created At'] as Timestamp;
                      DateTime date = t.toDate();
                      // print(DateFormat.yMMMd().format(DateTime(created)));

                      var docId = snapshot.data!.docs[Index].id;
                      return Card(
                        child: ListTile(
                          subtitle: Text(
                              '${_numberToMouthMap[date.month]} ${date.day}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () => {
                                        Get.to(UpdateDate(), arguments: {
                                          'note': note,
                                          'docId': docId
                                        })
                                      },
                                  child: Icon(Icons.edit)),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('notes')
                                        .doc(docId)
                                        .delete();
                                  },
                                  child: Icon(Icons.delete)),
                            ],
                          ),
                          title: Text(note),
                        ),
                      );
                    });
              }
              return Container(
                color: Colors.red,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() => Get.to(addNotes())),
        ));
  }
}
