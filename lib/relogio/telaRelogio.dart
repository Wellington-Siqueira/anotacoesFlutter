import 'package:flutter/material.dart';
import '../constants.dart';
import 'clock_draw.dart';
import 'horaDigital.dart';

class telaRelogio extends StatefulWidget {
  @override
  _telaRelogioState createState() => _telaRelogioState();
}

class _telaRelogioState extends State<telaRelogio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          color: Color(backgroudcolor),
          child: ClockDraw(),
          alignment: Alignment.center,
        ),
        Padding(
          padding: EdgeInsets.only(top: 25, bottom: 30),
          child: horaDigital(),
        ),
      ],
    );
  }
}
