import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:html';

class Dos extends StatefulWidget {
  @override
  _Dos createState() => _Dos();
}


class _Dos extends State<Dos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/unnamed.png'),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Nota Pedal'),
        ),
        body: Center(
          child: botonLa(),
        ),
      ),
    );

  }
}
class botonLa extends StatefulWidget {
  @override
  _botonLa createState() => _botonLa();
}


class _botonLa extends State<botonLa> {
  bool repit=true;
  int x=1;
  bool repit2=true;
  int x2=1;
  bool repit3=true;
  int x3=1;
  bool repit4=true;
  int x4=1;
  AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(

        child: Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    if(x%2==0){
                      repit=false;
                    }else{
                      repit=true;
                    }
                    await player.setAsset('assets/notaMi.mp3');
                    repit ? player.play() : player.stop();

                    x++;
                    print('Mi');
                  },
                  child: Text('Mi'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async{
                    if(x2%2==0){
                      repit2=false;
                    }else{
                      repit2=true;
                    }
                    await player.setAsset('assets/notaLa.mp3');
                    repit2 ? player.play() : player.stop();

                    x2++;
                  },
                  child: Text('La'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async{
                    if(x3%2==0){
                      repit3=false;
                    }else{
                      repit3=true;
                    }
                    await player.setAsset('assets/notaRe.mp3');
                    repit3 ? player.play() : player.stop();

                    x3++;
                  },
                  child: Text('Re'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async{
                    if(x4%2==0){
                      repit4=false;
                    }else{
                      repit4=true;
                    }
                    await player.setAsset('assets/notaSol.mp3');
                    repit4 ? player.play() : player.stop();

                    x4++;
                  },
                  child: Text('Sol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}