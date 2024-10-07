import 'package:calcualtor/UI/home_screen.dart';
import 'package:calcualtor/costum_widgets/custom_button.dart';
import 'package:calcualtor/utility/popup_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore userDb = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool isLoading= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your Tasks'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                // filled: true,
                // enabled: true,
                // labelText: 'text',
                // label: Text('text'),
                  hintText: 'Title',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: desController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                // filled: true,
                // enabled: true,
                // labelText: 'text',
                // label: Text('text'),
                  hintText: 'Description',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(8))),
            ),
            const Gap(20),
            CustomButton(
              height: 50.0,
              width: double.infinity,
              text: 'Add Task',
              isloading: isLoading,
              onPressed: (){
                setState(() {
                  isLoading = true;
                });

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                if(titleController.text.trim().isEmpty&&desController.text.trim().isEmpty){
                  ToastPupop().toastShow('Fields are empty', Colors.deepPurpleAccent, Colors.white);

                  setState(() {
                    isLoading = false;
                  });
                }else{
                  userDb.collection('userDb').doc(id).set({
                    'uid':auth.currentUser!.uid,
                    'id':id,
                    'title':titleController.text.trim(),
                    'description':desController.text.trim(),
                  }).then((value) {
                    ToastPupop().toastShow('Task Added', Colors.deepPurpleAccent, Colors.white);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                      return const HomeScreen();
                    }));
                  }).onError((error, stackTrace) {
                    ToastPupop().toastShow(error, Colors.deepPurpleAccent, Colors.white);
                    setState(() {
                      isLoading = false;
                    });
                  });

                  titleController.clear();
                  desController.clear();

                }



              },
            ),


          ],
        ),
      ),
    );
  }
}
