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
  int respostaCerta, contador =0;
  int r = 0, g=0;
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
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                            strokeWidth: 10.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Container(
                            color: Colors.redAccent,
                          );
                        } else {
                          if(tocando)
                          //return Container(color: Colors.pinkAccent, height: 50, width: double.infinity,);
                          return _createListView(context, snapshot);
                          else
                            return Container(color: Colors.red,width: 100, height: 100,);
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
        if(respostaCerta == contador){
          contador ++;
          return alternativas(snapshot, indexMusica);
        }
        int index = random.nextInt(199);
        contador ++;
        if(contador == 4)
          contador = 0;
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
    //alternativas();
    player.play(dados["tracks"][indexMusica]["previewURL"]).then((index) {
      setState(() {
        tocando = true;

      });
    });
  }

  Widget alternativas(snapshot, index) {
    return //Container(color: Colors.red, height: 100, width: 100,);
    GestureDetector(
      onTap: () {


      },
      child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Text(
                snapshot.data["tracks"][index]["name"],
                style: TextStyle(fontSize: 20),
              ),
              Text(
                snapshot.data["tracks"][index]["artistName"],
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}

//https://api.napster.com/v2.0/playlists/pp.225974698/tracks?apikey=MmM5OWY5MjQtM2NhYi00MDEzLWJmZTYtMjkxNDFlMWJjNDk5&limit=200
