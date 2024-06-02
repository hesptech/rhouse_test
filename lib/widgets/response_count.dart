import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_black_white/providers/repliers_filters.dart';

class ResponseCount extends StatefulWidget {

  //late int count;

  //ResponseCount({
  const ResponseCount({
    Key? key, 
    //this.count = 0, 
  }) : super(key: key);

  @override
  State<ResponseCount> createState() => _ResponseCountState();
}

class _ResponseCountState extends State<ResponseCount> {

  late int? count;

  @override
  void initState() {
    super.initState();
    //widget.count = 0;
  }

  @override
  Widget build(BuildContext context) {

    final repliersFilters = Provider.of<RepliersFilters>(context);

    return Text(
      //widget.count.toString(),
      repliersFilters.onCount.toString(),
      style: const TextStyle( fontSize: 14.0, fontWeight: FontWeight.bold ),
    );
  }
}