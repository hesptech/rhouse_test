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

class GreenDivider extends StatelessWidget {
  const GreenDivider({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => const Divider( 
    thickness: 2.0, 
    color: kSecondaryColor, 
    indent: 24.0, 
    endIndent: 24.0, 
    height: 0,
  );
}

class GreenDividerSlim extends StatelessWidget {
  const GreenDividerSlim({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => const Divider( 
    thickness: 0.8, 
    color: kSecondaryColor, 
    indent: 20.0, 
    endIndent: 20.0, 
    height: 0.0,
  );
}

class BlueDivider extends StatelessWidget {
  const BlueDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(
    thickness: 1.0, 
    color: kPrimaryColor, 
    indent: 12.0, 
    endIndent: 12.0, 
    height: 0,    
  );
}