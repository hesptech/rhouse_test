import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 95.0,),
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
            onPressed: () { },
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
    );
  }
}