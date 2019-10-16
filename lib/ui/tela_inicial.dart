import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzflutter/ui/tela_cadastro.dart';
import 'package:quizzflutter/ui/tela_ranking.dart';
import 'tela_desenvolvedores.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            color: Colors.blueGrey[200],
     padding: EdgeInsets.only(top: 150),
     child: Column(
           children: <Widget>[

             Row(
               children: <Widget>[
                 Container(
                   child: Text("Qual é a Música", style: TextStyle(fontSize: 50),),
                 ),
               ],
             ),

             Padding(
               padding: const EdgeInsets.only(top: 50),
               child: FlatButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaCadastro()));
                 },
                 child: Text("Iniciar Jogo", style: TextStyle(fontSize: 30)),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: FlatButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaRanking()));
                 },
                 child: Text("Ranking", style: TextStyle(fontSize: 30)),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: FlatButton(
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TelaInfos()));
                 },
                 child: Text("Desenvolvedores", style: TextStyle(fontSize: 30)),
               ),
             )
           ],
     ),
    ),

      )
    );
  }
}
