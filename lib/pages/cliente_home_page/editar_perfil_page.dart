import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_agendamento_pet/data/database_helper.dart';
import 'package:validators/validators.dart'; // Para validação de e-mail

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  String nomeUsuario = 'Carregando...';
  String emailUsuario = 'Carregando...';
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    String? emailSalvo = prefs.getString('email');

    if (emailSalvo == null || emailSalvo.isEmpty) {
      setState(() {
        nomeUsuario = 'Usuário Desconhecido';
        emailUsuario = 'Email não encontrado';
      });
      return;
    }

    final usuario = await DatabaseHelper.instance.buscarUsuarioPorEmail(
      emailSalvo,
    );

    if (usuario != null) {
      setState(() {
        nomeUsuario = usuario['nome'] ?? 'Sem nome';
        emailUsuario = usuario['email'] ?? emailSalvo;
      });
      _nomeController.text = nomeUsuario;
      _emailController.text = emailUsuario;
    } else {
      setState(() {
        nomeUsuario = 'Usuário Desconhecido';
        emailUsuario = emailSalvo;
      });
    }
  }

  Future<void> _salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    String nome = _nomeController.text;
    String email = _emailController.text;

    if (nome.isNotEmpty && email.isNotEmpty) {
      if (isEmail(email)) {
        await DatabaseHelper.instance.atualizarUsuario(nome, email);
        await prefs.setString('email', email);
        setState(() {
          nomeUsuario = nome;
          emailUsuario = email;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil atualizado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira um e-mail válido.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos os campos são obrigatórios!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarDados,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
