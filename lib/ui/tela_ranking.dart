import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:quizzflutter/ui/tela_editar.dart';

class TelaRanking extends StatefulWidget {
  @override
  _TelaRankingState createState() => _TelaRankingState();
}

class _TelaRankingState extends State<TelaRanking> {
  Map<String, dynamic> dados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Ranking",
        ),
      ),
      body:
      SingleChildScrollView(

      child:Container(
        padding: EdgeInsets.only(bottom: 600),
        color: Colors.blueGrey[200],
        child:
      FutureBuilder(
          future: _getSearch("http://qualeamusica.gearhostpreview.com/selecionadados.php"),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 10.0,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.redAccent,
                  );
                } else {
                  return Container(
                    color: Colors.blueGrey[200],
                    child: _createListView(context, snapshot),
                  );
                }
            }
          }),
      ),
      ),
    );
  }

  Widget _createListView(context, snapshot) {
    return ListView.builder(
      itemCount: snapshot.data["usuarios"].length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return alternativas(snapshot, index);
      },
    );
  }

  Widget alternativas(snapshot, index) {
    return Container(
      child: ListTile(
        onLongPress: (){
          _mostraOpcoes(context, int.parse(dados["usuarios"][index]["id"]));
        },
        leading: Icon(Icons.grade, color: index == 0 ? Colors.yellowAccent : index == 1 ? Colors.grey[700] : index == 2 ? Colors.yellow[800] : Colors.black, size: 25,),
        title: Text(
            dados["usuarios"][index]["nome"],
          style: TextStyle(
            fontSize: 25
          ),
        ),
        trailing: Text(
            dados["usuarios"][index]["pontos"],
          style: TextStyle(
              fontSize: 25
          ),
        ),
      )
    );
  }

  void _mostraOpcoes(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TelaEditar(index)));

                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _getDelete("http://qualeamusica.gearhostpreview.com/deletadados.php?id=${index}");
                          });
                        },
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  void _getDelete(String url) async {
    await http.get(url);
  }

  Future<Map> _getSearch(String url) async {
    http.Response response;
    response = await http.get(url);
    dados = convert.json.decode(response.body);
    return dados;
  }
}
