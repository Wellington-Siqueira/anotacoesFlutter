import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../constants.dart';

class ClockDraw extends StatefulWidget {
  @override
  _ClockDrawState createState() => _ClockDrawState();
}

class _ClockDrawState extends State<ClockDraw> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPaint(),
        ),
      ),
    );
  }
}

class ClockPaint extends CustomPainter {
  var horario = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centroX = size.width / 2;
    var centroY = size.height / 2;
    var centro = Offset(centroX, centroY);
    var raio = min(centroX, centroY);

    var borda = Paint()..color = Color(corBorda);
    var relogio = Paint()..color = Color(corRelogio);
    var centroPonteiros = Paint()..color = Color(corBorda);

    var ponteiroSeg = Paint()
      ..color = Color(corBorda)
      ..shader = RadialGradient(colors: [Colors.yellow, Colors.red])
          .createShader(Rect.fromCircle(center: centro, radius: raio))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    var ponteiroMin = Paint()
      ..color = Color(corBorda)
      ..shader = RadialGradient(colors: [Colors.red, Colors.deepPurple])
          .createShader(Rect.fromCircle(center: centro, radius: raio))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    var ponteiroHora = Paint()
      ..color = Color(corBorda)
      ..shader = RadialGradient(colors: [Colors.blue, Colors.purple])
          .createShader(Rect.fromCircle(center: centro, radius: raio))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 9;

    var marcacaoMenor = Paint()
      ..color = Color(corBorda)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var marcacaoMaior = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    //Calculo matematico para determinar a posição dos ponteiros
    var segX = centroX + 100 * cos(horario.second * 6 * pi / 180);
    var segY = centroX + 100 * sin(horario.second * 6 * pi / 180);

    var minX = centroX + 80 * cos(horario.minute * 6 * pi / 180);
    var minY = centroX + 80 * sin(horario.minute * 6 * pi / 180);

    var horaX = centroX +
        60 * cos((horario.hour * 30 + horario.minute * 0.5) * pi / 180);
    var horaY = centroX +
        60 * sin((horario.hour * 30 + horario.minute * 0.5) * pi / 180);

    canvas.drawCircle(centro, raio - 30, borda);
    canvas.drawCircle(centro, raio - 40, relogio);
    canvas.drawLine(centro, Offset(segX, segY), ponteiroSeg);
    canvas.drawLine(centro, Offset(minX, minY), ponteiroMin);
    canvas.drawLine(centro, Offset(horaX, horaY), ponteiroHora);
    canvas.drawCircle(centro, raio / 8, centroPonteiros);

    var outerCircleRadius = raio;
    var innerCircleRadius = raio - 14;
    for (double i = 0; i < 360; i += 30) {
      var x1 = centroX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centroX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centroX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centroX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), marcacaoMenor);

      if (i == 90 || i == 180 || i == 270 || i == 0) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), marcacaoMaior);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
