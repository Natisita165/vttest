import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int pos = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/logo.png'),
            fit: BoxFit.contain
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(''),
          ),
          body: Stack(
            children: <Widget>[
              widGen(0, -0.5, 200, 80, Colors.red[500], Colors.red[500], 'Pedal', '/dos'),
              widGen(0, 0, 200, 80, Colors.pink[500], Colors.pink[500], 'Metronome', '/tres'),
              widGen(0, 0.5, 200, 80, Colors.purple[500], Colors.purple[500], 'Afinador', '/cuatro'),
            ],
          ),
        ),
      ),
    );
  }

  Widget widGen(double x, double y, double w, double h, col1, col2, msg, m) {
    return Align(
      alignment: Alignment(x, y),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [col1, col2])
        ),


        child: FlatButton(
            child: Text(msg.toString(), style: TextStyle(fontSize: 20),),
            onPressed: () {
              Navigator.pushNamed(context, m);
            }),


      ),
    );
  }
}

