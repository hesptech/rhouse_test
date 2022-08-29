import 'package:flutter/material.dart';

class LoginAccountScreen extends StatelessWidget {
  
  const LoginAccountScreen({ Key? key }) : super(key: key);

  //final myController = TextEditingController(text: "Initial value");

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    //TextEditingController textController = TextEditingController(text: 'Once you delete the account, there is no going back, please be certain');
    //TextEditingController textController = TextEditingController();
    //textController.text = 'Once you delete the account, there is no going back, please be certain';

    return Scaffold(
      backgroundColor: const Color(0xFFE6E7E8),
      appBar: AppBar(

        leading: IconButton(
          onPressed: () { 
            Navigator.restorablePopAndPushNamed(context, '/'); 
          }, 
          icon: const Icon(Icons.close_outlined),
        ),
        centerTitle: true,
        title: const Text('User Account'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(50.0, 27.0, 50.0, 40.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.manage_accounts_outlined, color: Color(0xFF0BB48B), size: 28,),
                SizedBox(width: 8.0,),
                Text('Manage your account',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF2E3191),
                    //fontWeight: FontWeight.bold,
                  ),
                ),                
              ],
            ),

            
          ],
        ),
      ),
    ); 
  }
}
