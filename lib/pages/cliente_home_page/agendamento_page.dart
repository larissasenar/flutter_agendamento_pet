import 'package:flutter/material.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final _formKey = GlobalKey<FormState>();
  String _servicoSelecionado = 'Banho';
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Serviço'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _servicoSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Selecione o serviço',
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _servicoSelecionado = newValue!;
                  });
                },
                items:
                    ['Banho', 'Tosa', 'Vacina'].map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  _dataSelecionada == null
                      ? 'Selecione uma data'
                      : 'Data: ${_dataSelecionada?.toLocal().toString().split(' ')[0]}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    setState(() {
                      _dataSelecionada = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  _horaSelecionada == null
                      ? 'Selecione a hora'
                      : 'Hora: ${_horaSelecionada?.format(context)}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _horaSelecionada = pickedTime;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _dataSelecionada != null &&
                      _horaSelecionada != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Agendamento realizado!')),
                    );
                    // Aqui você pode chamar uma função para salvar o agendamento
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Confirmar Agendamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
