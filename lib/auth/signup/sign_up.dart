import 'package:calcualtor/UI/home_screen.dart';
import 'package:calcualtor/costum_widgets/custom_button.dart';
import 'package:calcualtor/utility/popup_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../signin/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ConfirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signUp() {
    setState(() {
      isLoading = true;
    });
    firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value) {
          ToastPupop().toastShow('signed up successfully ', Colors.deepPurpleAccent
              , Colors.white);
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const  SigninScreen();
          }));
          setState(() {
            isLoading = false;
          });
    }).onError((error, stackTrace){
      ToastPupop().toastShow(error, Colors.red, Colors.white);
      setState(() {
        isLoading = false;
      });
    });
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
               const  SizedBox(
                  height: 20,
                ),
               const  Center(child: Text('Sing Up Screen')),
               const  SizedBox(
                  height: 20,
                ),
            
                TextFormField(
                  validator: (userName) {
                    if (userName!.isEmpty) {
                      return 'Name is empty';
                    }
                    return null;
                  },
                  controller: userNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    // filled: true,
                    // enabled: true,
                    // labelText: 'text',
                    // label: Text('text'),
                      hintText: 'user name',
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
                const  SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Email is empty';
                    }
                    return null;
                  },
                  controller: emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      // filled: true,
                      // enabled: true,
                      // labelText: 'text',
                      // label: Text('text'),
                      hintText: 'abc@gmail.com',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      hintStyle: TextStyle(color: Colors.black45),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45, width: 2),
                          borderRadius: BorderRadius.circular(8))),
                ),
               const  SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Password is empty';
                    }
                    if(passwordController.text.length <8){
                      return 'Weak password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      // filled: true,
                      // enabled: true,
                      // labelText: 'text',
                      // label: Text('text'),
                      hintText: 'Password',
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
                const  SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Confirm p is empty';
                    }
                    if(passwordController.text.trim() !=ConfirmPasswordController.text.trim()){
                      return 'passwords do not matched';
                    }
                    return null;
                  },
                  controller: ConfirmPasswordController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    // filled: true,
                    // enabled: true,
                    // labelText: 'text',
                    // label: Text('text'),
                      hintText: 'Confirm Password',
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
               const  SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 50.0,
                  width: double.infinity,
                  isloading: isLoading,
                  fontSize: 20.0,
                  text: 'Sign up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                     signUp();
                    }
                  },
                ),
                const  SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Have already an account'),
                    TextButton(onPressed: (){
            
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return SigninScreen();
                      }));
                    }, child: Text('Sign In'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
