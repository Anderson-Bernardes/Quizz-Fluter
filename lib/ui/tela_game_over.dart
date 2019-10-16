import 'package:flutter/material.dart';
import 'package:quizzflutter/ui/tela_inicial.dart';
import 'package:http/http.dart' as http;

class TelaGameOver extends StatefulWidget {
  String jogador;
  int pontos;

  TelaGameOver(this.pontos, this.jogador);

  @override
  _TelaGameOverState createState() => _TelaGameOverState(this.pontos, this.jogador);
}

class _TelaGameOverState extends State<TelaGameOver> {
  String jogador;
  int pontos;
  _TelaGameOverState(this.pontos, this.jogador);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        padding: EdgeInsets.only(top: 150),
        child: Column(
          children: <Widget>[
            Text("GAME OVER",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent
            ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
                "O Jogador ${jogador} fez ${pontos.toString()} pontos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            RaisedButton(
              onPressed: (){
                print("indo pra o ranking");
                _getSearch();

              },
              child: Text(
                "Ranking",
                style: TextStyle(fontSize: 30),
              ),
            ),
            RaisedButton(
              onPressed: (){
                _getSearch();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (contexto) => TelaInicial()));
              },
              child: Text("Menu Principal",
                style: TextStyle(fontSize: 30),
              ),
            ),

          ],
        ),
      )),
    );
  }

  Future<Map> _getSearch() async {
    http.Response response;
    response = await http.get("http://qualeamusica.gearhostpreview.com/salvadados.php?nome=${jogador}&pontos=${pontos.toString()}");

    print(response.body);

    return null;
  }
}
