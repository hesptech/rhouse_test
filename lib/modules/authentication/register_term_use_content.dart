import 'package:flutter/material.dart';
import 'package:flutter_black_white/modules/authentication/widgets/steps_widget.dart';
import 'package:flutter_black_white/screens/register_pin_screen.dart';
import 'package:flutter_black_white/utils/constants.dart';

class RegisterTermUseContent extends StatelessWidget {
  const RegisterTermUseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleRegister(),
            const SizedBox(height: 15.0),
            const StepsWidget(
              stepFirst: StatusStep.done,
              stepSecond: StatusStep.current,
            ),
            const SizedBox(height: 20),
            Text(_paragraph1, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text(_paragraph2, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 20,
            ),
            Text(
              _title1,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_paragraph3, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(_paragraph4, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text(_paragraph5, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(_paragraph6, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text(
              _title2,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_paragraph7, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text(
              _title3,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_paragraph8, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 40.0),
            _actions(context),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _rejectButton(context),
        const SizedBox(width: 15),
        _acceptButton(context),
      ],
    );
  }

  Widget _rejectButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: kSecondaryColor,
            width: 2
          )
        ),
        backgroundColor: Colors.transparent,
      ),
      child: const Text(
        "Reject",
        style: TextStyle(fontWeight: FontWeight.bold, color: kSecondaryColor),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/");
      },
    );
  }

  Widget _acceptButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text(
        "Agree",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushNamed(context, RegisterPinScreen.pathScreen);
      },
    );
  }  

  Widget _titleRegister() {
    return const Center(
      child: Text(
        "Term of User",
        textAlign: TextAlign.center,
        style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  String get _paragraph1 {
    return "By using this app, you are agreeing to comply and be bound by the following terms of service and use. Please review the following terms in their entirety and ensure their comprehension before using and viewing this web site. Acknowledge and understand that the Terms of Use do not create an agency relationship and do not impose a financial obligation on the Registrant or create any representation agreement between the Registrant and the Participant. Acknowledges that you are entering into a lawful broker-consumer relationship with the Rhouze.";
  }

  String get _paragraph2 {
    return "Acknowledges that after the Terms of Use agreement is opened for viewing, a “mouse click” is sufficient to acknowledge agreement to those terms. Understand that Rhouze assume no responsibility for the accuracy of any information shown on Rhouze website and mobile app. Understand that all data obtained from the VOW (Virtual Office Website) is intended only for your personal, non-commercial use. Do have a bona fide interest in the purchase, sale, or lease of real estate of the type being offered through the VOW. Agree not to copy, redistribute, retransmit, or otherwise use any of the data or Listing Information provided, except in connection with the Consumer’s consideration of the purchase, sale, or lease of an individual property. Acknowledge the Board/Association ownership of and the validity of the copyright in the MLS® database. If at anytime, an agreement is entered between HouseSigma Inc. and Consumer imposing a financial obligation on the Consumer or creating representation of the Consumer by the Rhouze must be established separately from the Terms of Use, must be prominently labeled as such, and may not be accepted solely by mouse click.";
  }

  String get _title1 {
    return "Toronto Regional Real Estate Board";
  }

  String get _paragraph3 {
    return 'cknowledges TRREB’s ownership of, and the validity of TRREB’s proprietary rights and copyright in the MLS® database, MLS® data, TRREB’s MLS® System, and Listing Information. Agree not to directly or indirectly, display, post, disseminate, distribute, publish, broadcast, transfer, sell or sublicense any Listing Information to another individual or entity. The prohibited uses expressly include “scraping” (including “screen scraping” and “database scraping”), “data mining” or any other activity intended to collect, store, re-organize, summarize or manipulate any Listing Information or any related data. TREB, and other TREB Members or their duly authorized representatives might access the VOW for the purposes of verifying compliance with MLS® Rules and Policies (including the VOW Rules) and monitoring the display of Members’ Listings by the VOW.';
  }

  String get _paragraph4 {
    return "Information is deemed reliable but is not guaranteed accurate by TREB.";
  }

  String get _paragraph5 {
    return "Information Technology Systems Ontario Agree not copy, redistribute, or retransmit any of the VOW Content, except in connection with the VOW Customer’s consideration of the purchase or sale of an individual property. Acknowledges the Association’s ownership of and the validity of the Association’s copyrights in the MLS® System data.";
  }

  String get _paragraph6 {
    return "Despite the preceding provisions, the MLS®, Association and other Members and their duly authorized representatives may access the VOW for the purposes of verifying compliance with these Regional MLS® Rules and monitoring display of other Members’ listings by the VOW. Information is deemed reliable but is not guaranteed accurate by Information Technology Systems Ontario.";
  }

  String get _title2 {
    return "Copyright";
  }

  String get _paragraph7 {
    return "The content on this app is protected by copyright and other laws, and is intended solely for the private, non-commercial use by individuals. Any other reproduction, distribution or use of the content, in whole or in part, is specifically prohibited. Prohibited uses include commercial use, “screen scraping”, “database scraping”, and any other activity intended to collect, store, reorganize or manipulate the content of this app.";
  }

  String get _title3 {
    return "Trademarks";
  }

  String get _paragraph8 {
    return "REALTOR®, REALTORS®, and the REALTOR® logo are certification marks that are owned by REALTOR® Canada Inc.";
  }
}
