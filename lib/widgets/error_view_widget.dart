import 'package:flutter/material.dart';

class ErrorViewWidget extends StatelessWidget {
  const ErrorViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.error_outline,
              size: 65.0,
              color: Color(0XFFED1C24),
            ),
            SizedBox(height: 16.0),
            Text(
              'Oops, something went wrong',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Try again later',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
