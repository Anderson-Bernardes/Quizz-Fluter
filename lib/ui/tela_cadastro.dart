import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:audio_stream_player/audio_stream_player.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
/*String apiKey = "https://api.napster.com/v2.1/tracks/top?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5";
  curl -X GET  -H "apikey: {${apiKey}" "https://api.napster.com/v2.2/artists/top"*/
  /*@override
  void initState() {
    _getSearch();
    super.initState();
  }*/

  bool tocando = false;
  AudioStreamPlayer player = AudioStreamPlayer();
  Map<String, dynamic> dados;
  int indexMusica;
  var random = new Random();
  /*@override
  void initState() {
    // inicializando o objeto da classe Future no initState
    // que é chamado apenas quando o Widget entra pela primeira vez na árvore de widgets
    _getSearch();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    //initState();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Center(
                child: Text(
              "Aperte o Play para começar",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            )),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      if (!tocando)
                        play();
                      else
                        stop();
                    },
                    child: tocando
                        ? Icon(
                            Icons.pause,
                            size: 300,
                          )
                        : Icon(
                            Icons.play_arrow,
                            size: 300,
                          ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: _getSearch(),
                builder: (contexto, dados) {
                  switch (dados.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 10.0,
                      ),
                    );
                    default:
                      if (dados.hasError)
                      return Container();
                    else {
                      print("to retornando as alternativas");
                      return alternativas();
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  _getSearch() async {
    http.Response response;
    response = await http.get(
        //"https://api.napster.com/v2.0/playlists/pp.225974698/tracks?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&limit=200");
        "https://api.napster.com/v2.2/tracks/top?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&catalog=BR&limit=200");
    setState(() {
      dados = convert.json.decode(response.body);
    });
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
    alternativas();
    player.play(dados["tracks"][indexMusica]["previewURL"]).then((index) {
      setState(() {
        tocando = true;

      });
    });
  }

  Widget alternativas() {
    print("TO AQUI \n\n\n\n\n TO AQUI");
    String musica1 = dados["tracks"][indexMusica]["name"];
    String cantor1 = dados["tracks"][indexMusica]["artistName"];
    int index1 = indexMusica;

    int n1 = random.nextInt(199);
    if (n1 != indexMusica) {
      String musica2 = dados["tracks"][n1]["name"];
      String cantor2 = dados["tracks"][n1]["artistName"];
      int index2 = n1;
    }

    int n2 = random.nextInt(199);
    if (n2 != indexMusica && n2 != n1) {
      String musica3 = dados["tracks"][n2]["name"];
      String cantor3 = dados["tracks"][n2]["artistName"];
      int index3 = n2;
    }

    int n3 = random.nextInt(199);
    if (n3 != indexMusica && n3 != n1 && n3 != n1) {
      String musica4 = dados["tracks"][n3]["name"];
      String cantor4 = dados["tracks"][n3]["artistName"];
      int index4 = n3;
    }
    return GestureDetector(
      onTap: () {
        print("tap no 1");
      },
      child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Text(
                musica1,
                style: TextStyle(fontSize: 20),
              ),
              Text(cantor1),
            ],
          )),
    );
  }
}

//https://api.napster.com/v2.0/playlists/pp.225974698/tracks?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&limit=200
