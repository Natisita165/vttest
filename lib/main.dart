import 'package:flutter/material.dart';
import 'package:vttest/paginas/afinador.dart';
import 'package:vttest/paginas/pedal.dart';
import 'package:vttest/paginas/metronomo.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name){
          case '/':
            return MaterialPageRoute(builder: (context) => HomePage());
            break;
          case '/dos':
            return MaterialPageRoute(builder: (context) => Dos());
            break;
          case '/tres':
            return MaterialPageRoute(builder: (context) => Tres());
            break;
          case '/cuatro':
            return MaterialPageRoute(builder: (context) => Application());
            break;
        }
      },
    );
  }
}