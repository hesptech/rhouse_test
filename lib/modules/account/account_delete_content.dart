import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

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
    return const Text("This action cannot be undone. This will permanently delete all information assoociated with pepito@email.com account", textAlign: TextAlign.center, style: TextStyle(fontSize: 15),);
  }

  Widget _titleName() {
    return const Center(
      child: Text(
        "Pepito Perez",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _titleEmail() {
    return const Center(
      child: Text(
        "pepito@email.com",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
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
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      },
    );
  }

}
