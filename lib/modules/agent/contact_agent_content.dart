import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/response_listings.dart';
import 'package:flutter_black_white/utils/constants.dart';

class ContactAgentContent extends StatefulWidget {
  final Listing listing;
  const ContactAgentContent({super.key, required this.listing});

  @override
  State<ContactAgentContent> createState() => _ContactAgentContentState();
}

class _ContactAgentContentState extends State<ContactAgentContent> {
  late final TextEditingController _fullNameCtrl;
  late final TextEditingController _phoneNumberCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _messageCtrl;
  late final String textMessage = "2934W Silver Av. Collingwood, ON";

  String address = "";

  @override
  void initState() {
    _fullNameCtrl = TextEditingController(text: "Pepito Perez");
    _phoneNumberCtrl = TextEditingController(text: "");
    _emailCtrl = TextEditingController(text: "pepito@google.com");

    var addressObject = widget.listing.address;
    address = "${addressObject!.streetNumber} ${addressObject.streetName} ${addressObject.streetSuffix} ${addressObject.neighborhood} ${addressObject.city}";
    _messageCtrl = TextEditingController(text: "I am interested in this property \n$address");
    super.initState();
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneNumberCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameTextForm(),
            const SizedBox(
              height: 30,
            ),
            _phoneNumberTextForm(),
            const SizedBox(
              height: 30,
            ),
            _emailTextForm(),
            const SizedBox(
              height: 30,
            ),
            _messageTextForm(),
            const SizedBox(
              height: 30,
            ),
            _buttonContactAgent(context),
            const SizedBox(
              height: 20,
            ),            
          ],
        ),
      ),
    );
  }

  Widget _nameTextForm() {
    return TextFormField(
      controller: _fullNameCtrl,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Your Name",
        labelText: "Your Name*",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  Widget _phoneNumberTextForm() {
    return TextFormField(
      controller: _phoneNumberCtrl,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Your Contact Phone Number*",
        labelText: "Your Contact Phone Number*",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  Widget _emailTextForm() {
    return TextFormField(
      controller: _emailCtrl,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Your Email*",
        labelText: "Your Email*",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  Widget _messageTextForm() {
    return TextFormField(
      controller: _messageCtrl,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.phone,
      maxLines: 5,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Message*",
        labelText: "Message*",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  Widget _buttonContactAgent(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(320, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text(
        "CONTACT AGENT",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {},
    );
  }
}
