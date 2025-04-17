import 'package:flutter/material.dart';

class VacinacaoPage extends StatelessWidget {
  const VacinacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> vacinas = [
      {"vacina": "Vacina Anti-Rábica", "data": "12/03/2023"},
      {"vacina": "Vacina V8", "data": "05/01/2024"},
      // Adicione outras vacinas aqui
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carteira de Vacinação'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: vacinas.length,
        itemBuilder: (context, index) {
          final vacina = vacinas[index];
          return ListTile(
            leading: const Icon(Icons.vaccines, color: Colors.teal),
            title: Text(vacina['vacina']!),
            subtitle: Text('Aplicada em: ${vacina['data']}'),
          );
        },
      ),
    );
  }
}
