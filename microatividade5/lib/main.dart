import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a palavra "debug"
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), // Ajusta a altura do AppBar
          child: AppBar(
            automaticallyImplyLeading: false, // Remove o botão de retorno, se existir
            flexibleSpace: Container(
              color: Colors.blue, // Fundo do AppBar
              child: Center(
                child: Text(
                  'Stack Example',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Imagem aumentada com texto ajustado
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80, // Aumenta o raio da imagem
                    backgroundImage: AssetImage('assets/example.jpg'), // Substitua pelo caminho da sua imagem
                  ),
                  Positioned(
                    bottom: -0, // Ajusta o texto para ficar mais abaixo da imagem
                    child: Text(
                      'Mia B',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Blocos coloridos sobrepostos
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.red,
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
