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
    );
  }
}