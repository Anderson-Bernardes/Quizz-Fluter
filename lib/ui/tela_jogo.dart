import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:audio_stream_player/audio_stream_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:quizzflutter/ui/tela_game_over.dart';

class TelaJogo extends StatefulWidget {

  final String _nome;
  TelaJogo(this._nome);

  @override
  _TelaJogoState createState() => _TelaJogoState(this._nome);
}

class _TelaJogoState extends State<TelaJogo> {
  String _nome;
_TelaJogoState(this._nome);

  bool tocando = false;
  AudioStreamPlayer player = AudioStreamPlayer();
  Map<String, dynamic> dados;
  int indexMusica;
  var random = new Random();
  int respostaCerta, contador = 0;
  int r = 0, g = 0;
  static AudioCache plyr = AudioCache();
  int pontos=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogador: ${_nome} com ${pontos.toString()} pontos"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body:
         Container(
           padding: EdgeInsets.all(20),
           color: Colors.blueGrey[200],
           child: Column(
            children: <Widget>[
              Center(
                  child: !tocando ? Text(
                    "Aperte o Play para começar",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ): Container()),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      shape: CircleBorder(),
                      onPressed: () {
                        if (!tocando) {
                          play();
                        } else {
                          //stop();
                          //_startStopButtonPressed();
                        }
                      },
                      child: tocando
                          ? Icon(
                        Icons.queue_music,
                        size: 210,
                      )
                          : Icon(
                        Icons.play_arrow,
                        size: 230,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: _getSearch(),
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
                          if (tocando)
                            return _createListView(context, snapshot);
                          else
                            return Container(
                              child: Text(
                                "Ao apertar tocará 30 segundos da música!",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            );
                        }
                    }
                  }),
            ],
        ),
         ),

    );
  }

  Widget _createListView(context, snapshot) {
    return ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (respostaCerta == contador) {
          contador++;
          return alternativas(snapshot, indexMusica);
        }
        int index = random.nextInt(199);
        contador++;
        if (contador == 4) contador = 0;
        return alternativas(snapshot, index);
      },
    );
  }

  Future<Map> _getSearch() async {
    http.Response response;
    response = await http.get(
      //"https://api.napster.com/v2.0/playlists/pp.225974698/tracks?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&limit=200");
        "https://api.napster.com/v2.2/tracks/top?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&catalog=BR&limit=200");

    return dados = convert.json.decode(response.body);
  }

  stop() {
    player.stop().then((index) {
      setState(() {
        tocando = false;
      });
    });
  }

  play() {
    indexMusica = random.nextInt(199);
    print(dados["tracks"][indexMusica]["name"]);
    print(dados["tracks"][indexMusica]["artistName"]);
    print(dados["tracks"][indexMusica]["previewURL"]);

    respostaCerta = random.nextInt(3);
    player.play(dados["tracks"][indexMusica]["previewURL"]).then((index) {
      setState(() {
        tocando = true;
      });
    });
  }

  //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);


  Widget alternativas(snapshot, index) {
    return //Container(color: Colors.red, height: 100, width: 100,);
      GestureDetector(
        onTap: () {
          if (index == indexMusica){
            setState(() {
              pontos++;
            });
            player.stop();
            plyr.play('Faustão Acertou meme (1).mp3');
            print("ACERTOU MISERAVI");
            stop();
            play();
          }
          else
          {
            player.stop();

            plyr.play('Faustão - Errou! (2).mp3');
            print("ERROU");
            stop();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaGameOver(pontos, _nome)));
          }
        },
        child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Text(
                  snapshot.data["tracks"][index]["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  snapshot.data["tracks"][index]["artistName"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            )),
      );
  }
}
