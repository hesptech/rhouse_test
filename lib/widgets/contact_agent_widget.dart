import 'package:flutter/material.dart';

import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/screens/contact_agent_screen.dart';


class ContactAgentWidget extends StatelessWidget {

  final Listing listing;

  const ContactAgentWidget({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return listing.status == 'A' ? Container(
              height: 68,
              color: kSecondaryColor,
              padding: const EdgeInsets.fromLTRB(22.0, 15.0, 22.0, 15.0),
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ContactAgentScreen.pathScreen, arguments: listing);
                },
                child: Container(
                  //height: 30,
                  width: MediaQuery.of(context).size.width - 60,
                  //padding: const EdgeInsets.all(0.0),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    /* boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ] */
                  ),
                  child: const Align(
                    alignment: Alignment.center, 
                    child: Text(
                      "ask agent / book a viewing", 
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ) : const SizedBox( height: 0.0 );
  }
}