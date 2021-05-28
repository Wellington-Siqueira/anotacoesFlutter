import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

// ignore: camel_case_types
class horaDigital extends StatefulWidget {
  @override
  _horaDigitalState createState() => _horaDigitalState();
}

// ignore: camel_case_types
class _horaDigitalState extends State<horaDigital> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var horas = DateFormat('HH:mm:ss').format(now);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          horas,
          style: TextStyle(
              color: Color(corBorda),
              fontSize: 50,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
