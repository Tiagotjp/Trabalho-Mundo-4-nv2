import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompraPage extends StatefulWidget {
  final String destino;
  final String image;
  final String dataDisponivel;

  const CompraPage({
    super.key,
    required this.destino,
    required this.image,
    required this.dataDisponivel,
  });

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  String? _metodoPagamento;
  bool _pagamentoConfirmado = false;
  DateTime? _dataSelecionada;

  int _quantidadeAdultos = 1;
  int _quantidadeCriancas = 0;

  final _transportes = ['Avião', 'Autocarro', 'Comboio'];
  String _meioTransporteSelecionado = 'Avião';

  final String _localEmbarque = 'Terminal Central';

  void _finalizarCompra() {
    if (_dataSelecionada == null || _metodoPagamento == null) {
      _mostrarAviso('Por favor, preencha todas as informações.');
      return;
    }
    setState(() {
      _pagamentoConfirmado = true;
    });
  }

  void _mostrarAviso(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _selecionarData() async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (dataEscolhida != null) {
      setState(() {
        _dataSelecionada = dataEscolhida;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compra de Passagem'),
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
        child: _pagamentoConfirmado
            ? _buildMensagemSucesso()
            : _buildFormularioCompra(),
      ),
    );
  }

  // Tela de confirmação
  Widget _buildMensagemSucesso() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 20),
          Text(
            'Compra Confirmada!',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'Destino: ${widget.destino}\n'
            'Data: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada!)}\n'
            'Meio de Transporte: $_meioTransporteSelecionado\n'
            'Adultos: $_quantidadeAdultos, Crianças: $_quantidadeCriancas\n'
            'Embarque: $_localEmbarque\n'
            'Método de Pagamento: $_metodoPagamento',
            style: const TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Voltar à Página Inicial'),
          ),
        ],
      ),
    );
  }

  // Formulário de compra
  Widget _buildFormularioCompra() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Imagem do destino
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Título
        Text(
          widget.destino,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Seletor de data
        ElevatedButton.icon(
          onPressed: _selecionarData,
          icon: const Icon(Icons.calendar_today),
          label: const Text('Selecionar Data da Viagem'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
        ),
        if (_dataSelecionada != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Data: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada!)}',
              style: const TextStyle(color: Colors.yellow, fontSize: 16),
            ),
          ),

        // Quantidade de pessoas
        _buildQuantidadePessoas(),

        // Meio de transporte
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _meioTransporteSelecionado,
          items: _transportes.map((transporte) {
            return DropdownMenuItem(
              value: transporte,
              child: Text(transporte),
            );
          }).toList(),
          onChanged: (value) => setState(() => _meioTransporteSelecionado = value!),
          decoration: const InputDecoration(
            labelText: 'Meio de Transporte',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 16),
        // Método de pagamento
        _buildMetodoPagamento(),

        // Finalizar compra
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _finalizarCompra,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Finalizar Compra', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Widget _buildQuantidadePessoas() {
    return Column(
      children: [
        _buildStepper('Adultos', _quantidadeAdultos, (value) {
          setState(() => _quantidadeAdultos = value);
        }),
        _buildStepper('Crianças', _quantidadeCriancas, (value) {
          setState(() => _quantidadeCriancas = value);
        }),
      ],
    );
  }

  Widget _buildStepper(String label, int value, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.yellow),
              onPressed: () => onChanged(value > 0 ? value - 1 : 0),
            ),
            Text('$value', style: const TextStyle(color: Colors.white, fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.yellow),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetodoPagamento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Método de Pagamento:', style: TextStyle(fontSize: 18, color: Colors.yellow)),
        _buildOpcaoPagamento('Pix'),
        _buildOpcaoPagamento('Cartão de Crédito'),
        _buildOpcaoPagamento('Pagamento à Vista'),
      ],
    );
  }

  Widget _buildOpcaoPagamento(String metodo) {
    return ListTile(
      title: Text(metodo, style: const TextStyle(color: Colors.white)),
      leading: Radio<String>(
        value: metodo,
        groupValue: _metodoPagamento,
        activeColor: Colors.orange,
        onChanged: (value) => setState(() => _metodoPagamento = value),
      ),
    );
  }
}
