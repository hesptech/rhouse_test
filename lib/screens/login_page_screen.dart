import 'package:flutter/material.dart';

class LoginPageScreen extends StatelessWidget {
  
  const LoginPageScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E7E8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Log in or sign up'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(50.0, 70.0, 50.0, 95.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            
            SizedBox(height: 95.0,),
            Text('Sign up',
              style: TextStyle(
                fontSize: 22.0,
                color: Color(0xFF2E3191),
                //fontWeight: FontWeight.bold,
              ),
            ),
            
          ],
        ),
      ),
    ); 
  }
}

