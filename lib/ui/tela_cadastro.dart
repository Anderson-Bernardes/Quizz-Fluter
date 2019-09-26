import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child:Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              //backgroundImage: ,
            )
          ],
        ),
      ),
    )

      ;
  }
}
