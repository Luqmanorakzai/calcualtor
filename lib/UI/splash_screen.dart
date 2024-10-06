import 'package:calcualtor/UI/home_screen.dart';
import 'package:calcualtor/auth/signup/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    isLoading();
    // _navigate();
  }
  void isLoading()async{
     await Future.delayed(const Duration(seconds: 2),(){
       if(FirebaseAuth.instance.currentUser!=null){
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
           return const HomeScreen();
         }));
       }else{
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
           return const SignUpScreen();
         }));
       }

    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Center(
                child: Text(
                  'Hello Splash Screen',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
          ),
          // Image.asset('assets/images/shoe.jpeg')
        ],
      ),
    );
  }
}
