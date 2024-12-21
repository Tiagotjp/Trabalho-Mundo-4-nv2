import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Flutter - MaterialApp"), // Define o título do AppBar
    ),
  );
}

class StatelessWidgetExemplo extends StatelessWidget {
  final String _appBarTitle;

  StatelessWidgetExemplo(this._appBarTitle) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle), // Título do AppBar
        backgroundColor: Colors.blue, // Define o fundo azul para o AppBar
      ),
      body: Center(
        child: Text('Macoratti .net'), // Texto centralizado na tela
      ),
    );
  }
}
