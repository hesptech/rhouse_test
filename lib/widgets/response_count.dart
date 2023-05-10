import 'package:flutter/material.dart';

class ResponseCount extends StatefulWidget {

  int? count;

  ResponseCount({
    Key? key, this.count, 
  }) : super(key: key);

  @override
  State<ResponseCount> createState() => _ResponseCountState();
}

class _ResponseCountState extends State<ResponseCount> {

  late int? count;

  @override
  void initState() {
    super.initState();
    widget.count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.count.toString(),
      style: const TextStyle( fontSize: 14.0, fontWeight: FontWeight.bold ),
    );
  }
}