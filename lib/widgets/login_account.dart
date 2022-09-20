import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_black_white/utils/application_state.dart';
import 'package:flutter_black_white/utils/authentication.dart';
import 'package:provider/provider.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({Key? key}) : super(key: key);

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Row(
          children: const [
            Icon(Icons.manage_accounts_outlined, color: Color(0xFF0BB48B), size: 28,),
            SizedBox(width: 8.0,),
            Text('Manage your account',
              style: TextStyle(
                fontSize: 20.0,
                color: kPrimaryColor,
                //fontWeight: FontWeight.bold,
              ),
            ),                
          ],
        ),
        Consumer<ApplicationState>(
          builder: (context, appState, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                //const Text('User name'),
                //Text(FirebaseAuth.instance.currentUser?.displayName ?? 'no name'),
              ],

              const SizedBox( height: 32.0,),
              TextFormField(
                enabled: false,
                initialValue: FirebaseAuth.instance.currentUser?.metadata.creationTime.toString().replaceRange(16, null, '') ?? 'no signed id date',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                  label: const Text('Register on', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
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
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: kPrimaryColor,), 
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter email' : null ;
                },
              ), 

              // Full Name
              const SizedBox(height: 17.0,),
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: FirebaseAuth.instance.currentUser?.displayName ?? 'no name',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                  label: const Text('Full Name', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
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
                  suffixIcon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2E3191),
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter email' : null ;
                },
              ),

              
               
              /* const SizedBox(height: 17.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                  label: Text(FirebaseAuth.instance.currentUser?.email ?? 'no mail'),
                  labelStyle: const TextStyle(
                    color: kPrimaryColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never, 
                  suffixIcon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2E3191),
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter email' : null ;
                },
              ), */


              // Mail
              const SizedBox(height: 17.0,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: FirebaseAuth.instance.currentUser?.email ?? 'no mail',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                  label: const Text('Mail', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
                  //errorText: 'Error message',
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
                  suffixIcon: const Icon(
                    Icons.edit_outlined,
                    color: kPrimaryColor,  
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter mail' : null ;
                },
              ),


              // Password
              const SizedBox(height: 17.0,),
              TextFormField(
                obscureText: true,
                initialValue: 'password',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),

                  label: const Text('Password', style: TextStyle( color: Color(0xFF2E3191), fontWeight: FontWeight.w500, )),
                  //errorText: 'Error message',
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
                  suffixIcon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2E3191),
                    
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter password' : null ;
                },
              ),


              // Delete Acount
              const SizedBox(height: 17.0,),
              TextFormField(
                maxLines: 2,
                initialValue: 'Once you delete the account, there is no going back, please be certain.',
                style: const TextStyle(
                  //color: Colors.white,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                  label: const Text('Delete Account', style: TextStyle( color: kWarningColor, )),
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
                  suffixIcon: const Icon(
                    Icons.delete_outline_outlined,
                    color: kWarningColor,
                    
                  ),
                ),
                onChanged: (String value) {

                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter email' : null ;
                },
              ),


              /* SizedBox(
                height: screenSize.height - 630,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle( color: Color(0xFF58595B), fontSize: 12.0, ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Molestias aut, repellat ipsum facere voluptate dicta obcaecati deserunt nobis suscipit eaque?'
                          )
                        ]
                      )
                    ),
                  ],
                ),
              ), */
              SizedBox(
                height: screenSize.height - 630,
              )



            ],
          ),
        ),
      ],
    );
  }
}