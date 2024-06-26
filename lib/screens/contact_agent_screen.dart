import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/modules/agent/contact_agent_content.dart';

class ContactAgentScreen extends StatelessWidget {
  static String pathScreen = "contactAgent_Screen";

  const ContactAgentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listing = ModalRoute.of(context)!.settings.arguments as Listing;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: const Text('Account'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 34,
              )),
        ),
        body: SafeArea(child: ContactAgentContent(listing: listing,)));
  }
}
