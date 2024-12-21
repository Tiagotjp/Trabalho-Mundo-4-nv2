import 'package:flutter/material.dart';
import 'viagens_page.dart';
import 'contato_page.dart';
import 'sobre_page.dart';
import 'promocoes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMenuVisible = false;

  void toggleMenu() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel App'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(isMenuVisible ? Icons.close : Icons.menu),
            onPressed: toggleMenu,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fundo com gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFB2DFDB), // Verde claro
                  Color(0xFF0288D1), // Azul vibrante
                ],
              ),
            ),
          ),
          // Texto de boas-vindas centralizado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.airplanemode_active,
                  size: 80,
                  color: Colors.white.withOpacity(0.8),
                ),
                const SizedBox(height: 20),
                Text(
                  'Bem-vindo ao Travel App',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Menu flutuante
          if (isMenuVisible)
            Positioned(
              top: 0,
              right: 0,
              child: Material(
                elevation: 8,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: Container(
                  width: 250,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Navegação',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.flight_takeoff, color: Colors.blue),
                        title: const Text('Viagens'),
                        onTap: () {
                          toggleMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ViagensPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.contact_page, color: Colors.green),
                        title: const Text('Contato'),
                        onTap: () {
                          toggleMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ContatoPage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info, color: Colors.orange),
                        title: const Text('Sobre'),
                        onTap: () {
                          toggleMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SobrePage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.local_offer, color: Colors.red),
                        title: const Text('Promoções'),
                        onTap: () {
                          toggleMenu();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PromocoesPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
