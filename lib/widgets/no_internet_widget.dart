
import 'package:flutter/material.dart';

///Widget that displays a view to indicate that there is no internet
class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(height: 80.0),
            Icon(
              Icons.wifi_off,
              size: 200.0,
              color:  Color(0XFF09B68D),
            ),
            SizedBox(height: 16.0),
            Text(
              'No Internet connection',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'Try again later',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),            
          ],
        ),
      ),
    );
  }
}