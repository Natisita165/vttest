import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:html';
import 'package:fft/fft.dart';
import 'package:flutter_fft/flutter_fft.dart';
void main() => runApp(Application());

class Application extends StatefulWidget {
  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  double frequency;
  String note;
  bool isRecording;

  FlutterFft flutterFft = new FlutterFft();

  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "FFT",
      theme: ThemeData.dark(),
      color: Colors.red,
      home: Scaffold(
        appBar: AppBar(
          title: Text('FFT'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isRecording
                  ? Text(
                "Nota: $note",
                style: TextStyle(
                  fontSize: 35,
                ),
              )
                  : Text(
                "No funcionando",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              isRecording
                  ? Text(
                "Frecuencia: ${frequency.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 35,
                ),
              )
                  : Text(
                "No en uso",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _initialize() async {
    requestPermission("android.permission.RECORD_AUDIO", "IniciarAudio");
    print("Cargando.....");
    await flutterFft.startRecorder();
    print("Empezó");
    setState(() => {isRecording = flutterFft.getIsRecording},);
    flutterFft.onRecorderStateChanged.listen(
          (data) => {
        setState(
              () => {
            frequency = data[1],
            note = data[2],
          },
        ),
        flutterFft.setNote = note,
        flutterFft.setFrequency = frequency,
      },
    );
  }

  void requestPermission(String s, String t) {}

}




/*
class Cuatro extends StatefulWidget {
  @override
  _Cuatro createState() => _Cuatro();
}


class _Cuatro extends State<Cuatro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Text('Pagina Cuatro'),
      ),
    );
  }
}
main() {
  var data = [1.0, 0.0, -1.0, 0.0];
  var windowed = Window.Hann(data);
  var fft = new FFT().Transform(windowed);
}

class Hann {

}*/