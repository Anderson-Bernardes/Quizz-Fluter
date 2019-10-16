import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaEditar extends StatefulWidget {
  int id;

  TelaEditar(this.id);
  @override
  _TelaEditarState createState() => _TelaEditarState(this.id);
}

class _TelaEditarState extends State<TelaEditar> {
  int id;
  _TelaEditarState(this.id);
  String nome;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (texto){
                      setState(() {
                        nome = texto;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      labelText: 'Nome',
                    ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 150),
                        child: RaisedButton(
                          padding: EdgeInsets.all(30),
                          onPressed: (){
                            if(nome != null && nome !=""){
                              _getSearch("http://qualeamusica.gearhostpreview.com/editandodados.php?nome=${nome}&id=${id}");
                              Navigator.pop(context);
                            }

                          },
                          color: Colors.black,
                          child: Text(
                            "Confirmar",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
  void _getSearch(String url) async {
    await http.get(url);
  }
}
