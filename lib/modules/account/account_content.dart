import 'package:flutter/material.dart';
import 'package:flutter_black_white/providers/account/session_provider.dart';
import 'package:flutter_black_white/screens/account/account_change_password_screen.dart';
import 'package:flutter_black_white/screens/account/account_delete_screen.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/widgets/messaes_modals_widget.dart';

class AccountContent extends StatefulWidget {
  const AccountContent({super.key});

  @override
  State<AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent> {
  late final TextEditingController _registerOnCtrl;
  late final TextEditingController _fullNameCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _deleteAcccount;
  late final AuthSingleton authSingleton;

  @override
  void initState() {
    authSingleton = AuthSingleton();

    _registerOnCtrl = TextEditingController(text: authSingleton.authInfo.registrationDate);
    _fullNameCtrl = TextEditingController(text: "Name: ${authSingleton.authInfo.name} Last name: ${authSingleton.authInfo.lastName}");
    _passwordCtrl = TextEditingController(text: "123456789");
    _deleteAcccount = TextEditingController(text: "Once you delete the account, there is no going back, please be certain.");
    super.initState();
  }

  @override
  void dispose() {
    _registerOnCtrl.dispose();
    _fullNameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleName(),
              _lastName(),
              _titleEmail(),
              const SizedBox(
                height: 30,
              ),
              _itemFavourites(),
              const SizedBox(
                height: 15,
              ),
              _lineWidget(),
              const SizedBox(
                height: 10,
              ),
              _itemGuesses(),
              const SizedBox(
                height: 15,
              ),
              _lineWidget(),
              const SizedBox(
                height: 15,
              ),
              _titleManage(),
              const SizedBox(
                height: 15,
              ),
              _registerTextForm(),
              const SizedBox(
                height: 20,
              ),
              _fullNameTextForm(),
              const SizedBox(
                height: 20,
              ),
              _passwordTextForm(),
              const SizedBox(
                height: 20,
              ),
              _deleteAccountTextForm(),
              const SizedBox(
                height: 20,
              ),
              _buttondSignOut(),
              const SizedBox(
                height: 60,
              )
            ],
          )),
    );
  }

  Widget _titleName() {
    return Center(
      child: Text(
        "Name: ${authSingleton.authInfo.name}",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _lastName() {
    return Center(
      child: Text(
        "Last name: ${authSingleton.authInfo.lastName}",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }


  Widget _titleEmail() {
    return Center(
      child: Text("Email: ${authSingleton.authInfo.email}",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _itemFavourites() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Icon(
            Icons.favorite_outline,
            color: kSecondaryColor,
            size: 38,
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Text(
          "My favourites",
          style: TextStyle(color: kPrimaryColor, fontSize: 18),
        ),
        SizedBox(
          width: 60,
        ),
        Expanded(
          child: Icon(
            Icons.arrow_forward,
            color: kSecondaryColor,
            size: 38,
          ),
        ),
      ],
    );
  }

  Widget _itemGuesses() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('assets/play&learn_chip_53h.png'),
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Text(
          "My guesses",
          style: TextStyle(color: kPrimaryColor, fontSize: 18),
        ),
        SizedBox(
          width: 60,
        ),
        Expanded(
          child: Icon(
            Icons.arrow_forward,
            color: kSecondaryColor,
            size: 38,
          ),
        ),
      ],
    );
  }

  Widget _lineWidget() {
    return const Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Divider(color: kPrimaryColor, thickness: 1.3),
    );
  }

  Widget _titleManage() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.manage_accounts_outlined,
          color: kSecondaryColor,
          size: 38,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Manage your account",
          style: TextStyle(color: kPrimaryColor, fontSize: 18),
        )
      ],
    );
  }

  Widget _registerTextForm() {
    return TextFormField(
      controller: _registerOnCtrl,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Register on",
        labelText: "Register on",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColor),
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

  Widget _fullNameTextForm() {
    return TextFormField(
      controller: _fullNameCtrl,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Full Name",
        labelText: "Full Name",
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColor),
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

  Widget _passwordTextForm() {
    return TextFormField(
      controller: _passwordCtrl,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.left,
      readOnly: true,
      obscureText: true,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
        suffixIcon: _suffixPassword(),
        suffixIconColor: kPrimaryColor,
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColor),
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

  Widget _deleteAccountTextForm() {
    return TextFormField(
      controller: _deleteAcccount,
      keyboardType: TextInputType.visiblePassword,
      textAlign: TextAlign.left,
      readOnly: true,
      maxLines: 2,
      style: const TextStyle(
        color: kWarningColor,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Delete Account",
        labelText: "Delete Account",
        contentPadding: const EdgeInsets.only(top: 5.0, right: 10, left: 20.0),
        suffixIcon: _suffixDeleteAccount(),
        suffixIconColor: kWarningColor,
        labelStyle: const TextStyle(
          color: kWarningColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(fontWeight: FontWeight.w500, color: kWarningColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kWarningColor),
        ),
      ),
    );
  }

  Widget _buttondSignOut() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kSecondaryColor,
      ),
      child: const Text(
        "SIGN OUT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      onPressed: () {
        MessagesDialogsWidget.dialogInformation(
            title: const Text(
              "Session",
            ),
            content: const Text(
              "Are you sure you want to log out?",
              style: TextStyle(fontSize: 13),
            ),
            ok: _ok);
      },
    );
  }

  void _ok() {
    SessionProvider.close();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  Widget _suffixPassword() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AccountChangePasswordScreen.pathScreen);
      },
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          border: Border.all(width: 1, style: BorderStyle.solid, color: kPrimaryColor),
        ),
        child: const Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }

  Widget _suffixDeleteAccount() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AccountDeleteScreen.pathScreen);
      },
      child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: kWarningColor,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            border: Border.all(width: 1, style: BorderStyle.solid, color: kWarningColor),
          ),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}
