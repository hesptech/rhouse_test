import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/navigator_config.dart';
import 'package:flutter_black_white/providers/account/account_delete_provider.dart';
import 'package:flutter_black_white/utils/authentication_singleton.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/widgets/messaes_modals_widget.dart';

class AccountDeleteContent extends StatelessWidget {
  const AccountDeleteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleName(),
            _titleEmail(),
            const SizedBox(
              height: 30,
            ),
            _titleConfirm(),
            const SizedBox(
              height: 30,
            ),
            _buttondSignOut(context)
          ],
        ),
      ),
    );
  }

  Widget _titleConfirm() {
    return const Text(
      "This action cannot be undone. This will permanently delete all information assoociated with pepito@email.com account",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    );
  }

  Widget _titleName() {
    return  Center(
      child: Text("${AuthSingleton().authInfo.name} ${AuthSingleton().authInfo.lastName}",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _titleEmail() {
    return Center(
      child: Text(AuthSingleton().authInfo.email,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }



  Widget _buttondSignOut(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: kWarningColor,
      ),
      child: const Text(
        "DELETE MY ACCOUNT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      onPressed: () {
        MessagesDialogsWidget.dialogInformation(
            title: const Text("Delete account"),
            content: const Text(
              "Are you sure you want to delete your account?",
              style: TextStyle(fontSize: 13),
            ),
            ok: _ok);
      },
    );
  }

  void _ok() {
    NavigatorConfig.pop();
    AccountDeleteProvider().deleteAccount();
  }
}
