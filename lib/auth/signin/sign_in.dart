import 'package:calcualtor/UI/home_screen.dart';
import 'package:calcualtor/auth/signup/sign_up.dart';
import 'package:calcualtor/costum_widgets/custom_button.dart';
import 'package:calcualtor/utility/popup_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  //// function area
  void singin() async {
    setState(() {
      isLoading = true;
    });
    await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return const HomeScreen();
          }));
          ToastPupop().toastShow('Signed In Successfully', Colors.deepPurpleAccent, Colors.white);
          setState(() {
            isLoading = false;
          });

    }).onError((error, stackTrace) {
      ToastPupop().toastShow(error, Colors.deepPurpleAccent, Colors.white);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('sign in screen'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [ TextFormField(
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
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Password is empty';
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

                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 50.0,
                  width: double.infinity,
                  isloading: isLoading,
                  fontSize: 20.0,
                  text: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      singin();
                    }
                  },
                ),
                const  SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const  Text('Have not an account?'),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return const SignUpScreen();
                      }));
                    }, child: const Text('Sign up'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
