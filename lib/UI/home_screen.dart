import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title:const  Text('Home Screen'),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Log Out',style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: (){
                    // log out user from here


                  },
                      icon: const Icon(Icons.login_outlined))
                ],
              )
            ],
          ),
        ),
      ),
      body:const  Center(
        child:  Text('Welcome to Home Screen'),
      ),
    );
  }
}
