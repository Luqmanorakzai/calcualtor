import 'package:calcualtor/UI/add_task_screen.dart';
import 'package:calcualtor/auth/signin/sign_in.dart';
import 'package:calcualtor/costum_widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utility/popup_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userDb = FirebaseFirestore.instance.collection('userDb').snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Screen'),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          // log out user from here
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const SigninScreen();
                          }));
                        },
                        icon: const Icon(Icons.login_outlined))
                  ],
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: StreamBuilder<QuerySnapshot>(
                    stream: userDb,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      // handle error hare
                      if (snapshot.hasError) {
                        ToastPupop().toastShow('You faced error',
                            Colors.deepPurpleAccent, Colors.white);
                      } else if (snapshot.hasData) {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  // return ListTile(
                                  //   title: Text(snapshot.data!.docs[index]['title']),
                                  //   subtitle: Text(snapshot.data!.docs[index]['description']),
                                  // );
                                  return Container(
                                    height: 120,
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurpleAccent),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['title'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Gap(20),
                                          Text(
                                            snapshot.data!.docs[index]['description'],
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                      }
                      return SizedBox();
                    }),
              ),
              Expanded(
                  flex: -4,
                  child: CustomButton(
                    height: 50.0,
                    width: double.infinity,
                    text: 'Add Task',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const AddTaskScreen();
                      }));
                    },
                  ))
            ],
          ),
        ));
  }
}
