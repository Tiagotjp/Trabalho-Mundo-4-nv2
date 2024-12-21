import 'package:flutter/material.dart';
import '../pages/viagens_page.dart';
import '../pages/contato_page.dart';
import '../pages/sobre_page.dart';
import '../pages/promocoes_page.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
            ),
            child: const Text(
              'Travel App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.flight_takeoff),
            title: const Text('Viagens'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViagensPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page),
            title: const Text('Contato'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContatoPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SobrePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Promoções'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PromocoesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
