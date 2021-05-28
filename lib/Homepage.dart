import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:relogio_anotacoes/relogio/telaRelogio.dart';
import 'anotação/Anotacao.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceSelecionado = 0;
  List<Widget> _telas = [
    telaRelogio(),
    TarefasSalvas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroudcolor),
      body: _telas[_indiceSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSelecionado,
        onTap: (indice) {
          setState(() {
            _indiceSelecionado = indice;
          });
        },
        backgroundColor: Color(backgroudcolor),
        fixedColor: Color(corBorda),
        items: [
          BottomNavigationBarItem(
              title: Text("Inicio"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Anotações"), icon: Icon(Icons.note_add)),
        ],
      ),
    );
  }
}
