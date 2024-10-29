import 'package:calcualtor/UI/add_task_screen.dart';
import 'package:calcualtor/auth/signin/sign_in.dart';
import 'package:calcualtor/auth/signup/sign_up.dart';
import 'package:calcualtor/costum_widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utility/popup_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // if we want to get current user task only so apply query for
  // first get user id form auth in a string
  var userDb = FirebaseFirestore.instance.collection('userDb').snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // local area for the current context
    // if we want to get current user task only so apply query for
    // first get user id from auth in a string
    String uid = auth.currentUser!.uid;
    //apply the query on the above userDb ref of userDb in fire store
    // store the data in udb to show
    final udb = FirebaseFirestore.instance.collection('userDb').where('uid',isEqualTo: uid).snapshots();
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
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text('Log out confirmation'),
                              content:const Text('Are you sure to log out?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child:
                                const Text('No')
                                ),
                                TextButton(onPressed: (){
                                  //// log out user from here
                                  if(auth.currentUser!=null){
                                    auth.signOut().then((value) {
                                      ToastPupop().toastShow('Signed out successfully', Colors.deepPurpleAccent, Colors.white);
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                        return const  SigninScreen();
                                      }));
                                    }).catchError((error){
                                      ToastPupop().toastShow(error, Colors.deepPurpleAccent, Colors.redAccent);

                                    });
                                  }

                                }, child:
                                const Text('Yes')
                                ),
                              ],
                            );
                          });
                        },
                        icon: const Icon(Icons.logout_outlined))
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: ()async {
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text('Delete account confirmation'),
                              content:const Text('Are you sure to delete?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child:
                                const Text('No')
                                ),
                                TextButton(onPressed: ()async{
                                  //// log out user from here
                                  if(auth.currentUser!=null){
                                    await auth.currentUser!.delete().then((value) {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(builder: (context) {
                                        return const SignUpScreen();
                                      }));
                                      ToastPupop().toastShow('Account deleted  successfully', Colors.deepPurpleAccent, Colors.white);
                                    }).onError((error, stackTrace) {
                                      ToastPupop().toastShow(error, Colors.deepPurpleAccent, Colors.redAccent);
                                    });
                                  }
                                }, child:
                                const Text('Delete')
                                ),
                              ],
                            );
                          });
                        },
                        icon: const Icon(Icons.delete_outline))
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
              //for show tasks 
              Expanded(
                flex: 10,
                child: StreamBuilder<QuerySnapshot>(
                  // the store date in udb will carry the data in stream
                    stream: udb,
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
                                    margin: const EdgeInsets.only(bottom: 10),
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
              
              
              //for add task button 
              Expanded(
                  flex: -4,
                  child: CustomButton(
                    height: 50.0,
                    width: double.infinity,
                    text: 'Add Task',
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                        return const AddTaskScreen();
                      }));
                    },
                  )),
            ],
          ),
        ));
  }
}
