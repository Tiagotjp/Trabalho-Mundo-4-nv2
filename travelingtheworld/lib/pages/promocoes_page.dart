import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Pacote para abrir URLs
import 'detalhe_promocao_page.dart';
import 'compra_page.dart';

class PromocoesPage extends StatefulWidget {
  const PromocoesPage({super.key});

  @override
  _PromocoesPageState createState() => _PromocoesPageState();
}

class _PromocoesPageState extends State<PromocoesPage> {
  final List<Map<String, dynamic>> promocoes = [
    {
      'name': 'Cancún - México',
      'image': 'assets/cancun.jpeg',
      'description': 'Aproveite o paraíso mexicano.',
      'price': '€999',
      'favorites': 50,
      'comments': [
        {'name': 'João', 'comment': 'Viagem incrível, recomendo!'},
        {'name': 'Maria', 'comment': 'Cancún é maravilhoso, voltarei!'},
      ],
    },
    {
      'name': 'Paris - França',
      'image': 'assets/paris.jpeg',
      'description': 'Pacote romântico para casais.',
      'price': '€1,200',
      'favorites': 80,
      'comments': [
        {'name': 'Ana', 'comment': 'A cidade mais romântica do mundo!'},
        {'name': 'Carlos', 'comment': 'Passeio inesquecível pela Torre Eiffel!'},
      ],
    },
    {
      'name': 'Orlando - EUA',
      'image': 'assets/orlando.jpeg',
      'description': 'Diversão garantida para toda a família.',
      'price': '€1,500',
      'favorites': 120,
      'comments': [
        {'name': 'Beatriz', 'comment': 'As crianças amaram os parques!'},
        {'name': 'Pedro', 'comment': 'Disney é sempre mágico!'},
      ],
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
        title: const Text('Promoções'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB2DFDB),
              Color(0xFF0288D1),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: promocoes.length,
          itemBuilder: (context, index) {
            final promocao = promocoes[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Column(
                children: [
                  // Imagem
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      promocao['image'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Informações da promoção
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título e curtidas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                promocao['name'],
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade700,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      promocao['favorites'] += 1;
                                    });
                                  },
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${promocao['favorites']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Descrição
                        Text(
                          promocao['description'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                              ),
                        ),
                        const SizedBox(height: 8),
                        // Preço e botões
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              promocao['price'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhePromocaoPage(
                                          name: promocao['name'],
                                          image: promocao['image'],
                                          description: promocao['description'],
                                          price: promocao['price'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 12.0,
                                    ),
                                    backgroundColor: Colors.blue.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Ver Detalhes',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CompraPage(
                                          destino: promocao['name'],
                                          image: promocao['image'],
                                          dataDisponivel: '10/10/2024',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Comprar'),
                                ),
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.share, color: Colors.blue.shade700),
                                  onSelected: (value) {
                                    final message =
                                        'Confira esta promoção: ${promocao['name']}!\nDescrição: ${promocao['description']}\nPreço: ${promocao['price']}';
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
                        const Divider(),
                        // Seção de comentários fixos
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Comentários de viajantes:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            for (var comment in promocao['comments'])
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  '- ${comment['name']}: ${comment['comment']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade800,
                                  ),
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
