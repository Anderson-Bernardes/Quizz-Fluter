import 'package:flutter/material.dart';
import 'package:quizzflutter/ui/tela_jogo.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  String nome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nome do Jogador"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.blueGrey[200],
        child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  autocorrect: true,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  maxLength: 20,
                  onChanged: (texto){
                    setState(() {
                      nome = texto;
                    });
                  },
                   decoration: InputDecoration(
                    hintText: 'Nome',
                    labelText: 'Nome',
                     labelStyle: TextStyle(
                       color: Colors.black,
                       fontSize: 20.0,
                     ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                       padding: EdgeInsets.only(top: 100),
                      child: RaisedButton(
                        padding: EdgeInsets.all(25),
                        onPressed: (){
                          if(nome != null && nome !=""){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TelaJogo(nome)));
                          }

                        },
                        color: Colors.black,
                        child: Text(
                          "Jogar!",
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
      ),
    );
  }
}