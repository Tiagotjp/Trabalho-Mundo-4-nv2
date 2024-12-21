import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Pacote para abrir URLs
import 'detalhe_page.dart';
import 'compra_page.dart';

class ViagensPage extends StatefulWidget {
  const ViagensPage({super.key});

  @override
  _ViagensPageState createState() => _ViagensPageState();
}

class _ViagensPageState extends State<ViagensPage> {
  // Lista de viagens e favoritos
  final List<Map<String, dynamic>> viagens = [
    {
      'name': 'Maldivas',
      'image': 'assets/maldivas.jpeg',
      'description': 'Um paraíso para relaxar.',
      'price': '€2,000',
      'favorites': 120,
    },
    {
      'name': 'Fernando de Noronha',
      'image': 'assets/noronha.jpeg',
      'description': 'Natureza intocada no Brasil.',
      'price': '€1,700',
      'favorites': 85,
    },
    {
      'name': 'Cidade de Orlando',
      'image': 'assets/orlando.jpeg',
      'description': 'Um lugar encantador.',
      'price': '€1,300',
      'favorites': 98,
    },
    {
      'name': 'Paris',
      'image': 'assets/paris.jpeg',
      'description': 'Conhecida como cidade Luz.',
      'price': '€1,200',
      'favorites': 150,
    },
  ];

  // Função para abrir aplicativos de mídia social
  void _shareOnSocialMedia(String app, String message) async {
    final Uri uri;
    switch (app) {
      case 'whatsapp':
        uri = Uri.parse('https://wa.me/?text=$message');
        break;
      case 'instagram':
        uri = Uri.parse('https://www.instagram.com/');
        break;
      case 'facebook':
        uri = Uri.parse('https://www.facebook.com/sharer/sharer.php?u=$message');
        break;
      default:
        return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o $app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFB2DFDB), Color(0xFF0288D1)],
          ),
        ),
        child: ListView.builder(
          itemCount: viagens.length,
          itemBuilder: (context, index) {
            final viagem = viagens[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              elevation: 8,
              shadowColor: Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // Imagem
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      viagem['image'],
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Informações e Botões
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome e Ícone de Favoritar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                viagem['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      viagem['favorites'] += 1;
                                    });
                                  },
                                ),
                                Text(
                                  '${viagem['favorites']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          viagem['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Preço e Botões
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              viagem['price'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhePage(
                                          title: viagem['name'],
                                          price: viagem['price'],
                                          description: viagem['description'],
                                          image: viagem['image'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  child: const Text('Ver Detalhes'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CompraPage(
                                          destino: viagem['name'],
                                          image: viagem['image'],
                                          dataDisponivel: '09/09/2024',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                  child: const Text('Comprar'),
                                ),
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.share, color: Colors.blue.shade700),
                                  onSelected: (value) {
                                    final message =
                                        'Confira esta viagem: ${viagem['name']}!\nDescrição: ${viagem['description']}\nPreço: ${viagem['price']}';
                                    _shareOnSocialMedia(value, message);
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'whatsapp',
                                      child: Text('WhatsApp'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'instagram',
                                      child: Text('Instagram'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'facebook',
                                      child: Text('Facebook'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        // Seção de Comentários
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Comentários:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '"Lugar maravilhoso, recomendo a todos!" - Ana',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '"Experiência incrível, quero voltar!" - João',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
