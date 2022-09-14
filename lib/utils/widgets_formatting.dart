import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {Key? key} ) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {Key? key} ) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {Key? key} ) : super(key: key);
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({Key? key, required this.child, required this.onPressed}) : super(key: key);
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: kSecondaryColor),
      backgroundColor: kSecondaryColor,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
    ),
    onPressed: onPressed,
    child: child,
  );
}

class StyledMaterialButton extends StatelessWidget {
  const StyledMaterialButton({Key? key, required this.child, required this.onPressed}) : super(key: key);
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
    elevation: 0.0,
    minWidth: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
    color: kSecondaryColor,
    textColor: Colors.white,
    onPressed: onPressed,
    child: child,
  );
}