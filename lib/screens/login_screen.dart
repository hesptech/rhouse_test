import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Log in or sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 70.0, 50.0, 0),
        //padding: const EdgeInsets.symmetric( horizontal: 50.0, vertical: 70.0 ),
        child: SingleChildScrollView(
          child: Column(
            children: [
        
                  TextFormField(
                    //controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor, ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor,), 
                      ),                      
                      //hintText: 'Email',
                      label: const Center(
                        child: Text("Email"),
                      ),
                      //labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: kPrimaryColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //hintStyle: kStInputFieldLog
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address to continue';
                      }
                      return null;
                    },
                  ),
                  const SizedBox( height: 16.0, ), 
        
        
                  TextFormField(
                    //controller: _passwordController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor, ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kPrimaryColor,), 
                      ), 
                      label: const Center(
                        child: Text("Password"),
                      ),
                      labelStyle: const TextStyle(
                        color: kPrimaryColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox( height: 16.0, ),
        
        
        
                  StyledMaterialButton(
                    onPressed: () async {
        
                    },
                    child: const Text('LOG IN', style: TextStyle( fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold), ),
                  ),
        
        
        
        
        
                    const SizedBox(height: 65.0,),
                    const Text('Sign up',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: kPrimaryColor,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0,),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () { 
                          //Navigator.pushNamed(context, 'login_signup_screen'); 
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                            ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.email_outlined, size: 28.0, color: Color(0xFF0BB48B), ),
                            SizedBox(width : 10),
                            Text("Continue with Email", style: TextStyle( color: kPrimaryColor, ),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                            ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/icons_methods/icon_apple.png"),
                            const SizedBox(width : 10),
                            const Text("Continue with Apple", style: TextStyle( color: kPrimaryColor, ),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                            ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/icons_methods/Google_2.png"),
                            const SizedBox(width : 10),
                            const Text("Continue with Google", style: TextStyle( color: kPrimaryColor, ),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide( color: kPrimaryColor, ), ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
                            padding: MaterialStateProperty.all( const EdgeInsets.symmetric( vertical: 14 ), ),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                            ))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/icons_methods/icon_facebook.png"),
                            const SizedBox(width : 10),
                            const Text("Continue with Facebook", style: TextStyle( color: kPrimaryColor, ),),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      )




    );     
  }
}
