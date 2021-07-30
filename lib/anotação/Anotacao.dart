import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:relogio_anotacoes/helper/AnotacaoHelper.dart';
import 'package:relogio_anotacoes/helper/model/modelAnotacao.dart';

import '../constants.dart';

class TarefasSalvas extends StatefulWidget {
  @override
  _TarefasSalvasState createState() => _TarefasSalvasState();
}

class _TarefasSalvasState extends State<TarefasSalvas> {
  TextEditingController _titulocontroller = TextEditingController();
  TextEditingController _descricaocontroller = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = List<Anotacao>();

  _removerAnotacoes(int id) async {
    await _db.removerAnotacao(id);
    _recuperAnotacoes();
  }

  _recuperAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperAnotacoes();
    List<Anotacao> listaTemporaria = List<Anotacao>();

    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = null;
  }

  _salvarAtualizarAnotacao({Anotacao anotacaoAtualizada}) async {
    String titulo = _titulocontroller.text;
    String descricao = _descricaocontroller.text;

    if (anotacaoAtualizada == null) {
      //adicionar
      Anotacao anotacao =
          Anotacao(titulo, descricao, DateTime.now().toString());
      int resultado = await _db.salvarAnotacao(anotacao);
    } else {
      //atualizar
      anotacaoAtualizada.titulo = titulo;
      anotacaoAtualizada.descricao = descricao;
      anotacaoAtualizada.data = DateTime.now().toString();
      int resultado = await _db.atualizarAnotacao(anotacaoAtualizada);
    }

    _titulocontroller.clear();
    _descricaocontroller.clear();

    _recuperAnotacoes();
  }

  _exibirCriarAnotacao({Anotacao anotacao}) {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      _titulocontroller.text = "";
      _descricaocontroller.text = "";
      textoSalvarAtualizar = "Adicionar";
    } else {
      _titulocontroller.text = anotacao.titulo;
      _descricaocontroller.text = anotacao.descricao;
      textoSalvarAtualizar = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(primaryColor),
            title: Text(
              "$textoSalvarAtualizar anotação",
              style: TextStyle(color: Color(secondaryColor)),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: TextStyle(color: Color(secondaryColor)),
                    controller: _titulocontroller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Titulo",
                        hintText: "Digite um titulo...",
                        hintStyle: TextStyle(color: Color(secondaryColor)),
                        labelStyle: TextStyle(
                            color: Color(secondaryColor),
                            fontWeight: FontWeight.w600)),
                  ),
                  TextField(
                    style: TextStyle(color: Color(secondaryColor)),
                    cursorColor: Color(secondaryColor),
                    controller: _descricaocontroller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Descrição",
                        hintText: "Digite a anotação...",
                        hintStyle: TextStyle(color: Color(secondaryColor)),
                        labelStyle: TextStyle(
                            color: Color(secondaryColor),
                            fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Color(secondaryColor)),
                  )),
              FlatButton(
                  onPressed: () {
                    _salvarAtualizarAnotacao(anotacaoAtualizada: anotacao);
                    Navigator.pop(context);
                  },
                  child: Text(textoSalvarAtualizar,
                      style: TextStyle(color: Color(secondaryColor))))
            ],
          );
        });
  }

  _formatarData(String data) {
    initializeDateFormatting("pt_BR");
    //var _formatador = DateFormat("d/MM/y H:m");
    var _formatador = DateFormat.yMd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = _formatador.format(dataConvertida);
    return dataFormatada;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(primaryColor),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Text(
              "ANOTAÇÕES",
              style: TextStyle(
                  color: Color(secondaryColor),
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              final item = _anotacoes[index];
              return Dismissible(
                  onDismissed: (direction) {
                    _removerAnotacoes(item.id);
                  },
                  background: Card(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            "EXCLUIR",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(item.id.toString()),
                  child: Card(
                    child: ListTile(
                      title: Text(item.titulo),
                      subtitle: Text(
                          "${_formatarData(item.data)} - ${item.descricao}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _exibirCriarAnotacao(anotacao: item);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child:
                                  Icon(Icons.edit, color: Color(primaryColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            itemCount: _anotacoes.length,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 36),
        foregroundColor: Color(primaryColor),
        backgroundColor: Color(secondaryColor),
        onPressed: () {
          _exibirCriarAnotacao();
        },
      ),
    );
  }
}
