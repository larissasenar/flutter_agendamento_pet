import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_agendamento_pet/data/database_helper.dart';

class ClienteHomePage extends StatefulWidget {
  const ClienteHomePage({super.key});

  @override
  State<ClienteHomePage> createState() => _ClienteHomePageState();
}

class _ClienteHomePageState extends State<ClienteHomePage> {
  int _selectedIndex = 0;
  String nomeUsuario = 'Carregando...';
  String emailUsuario = 'Carregando...';
  File? imagemPerfil;

  final List<Widget> _screens = [
    const AgendamentosPage(),
    const ServicosPage(),
    const PerfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  Future<void> _carregarDadosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    String? emailSalvo = prefs.getString('email');

    if (emailSalvo == null || emailSalvo.isEmpty) {
      if (!mounted) return;
      setState(() {
        nomeUsuario = 'Usuário Desconhecido';
        emailUsuario = 'Email não encontrado';
      });
      return;
    }

    final usuario = await DatabaseHelper.instance.buscarUsuarioPorEmail(
      emailSalvo,
    );

    if (!mounted) return;
    if (usuario != null) {
      setState(() {
        nomeUsuario = usuario['nome'] ?? 'Sem nome';
        emailUsuario = usuario['email'] ?? emailSalvo;
      });
    } else {
      setState(() {
        nomeUsuario = 'Usuário Desconhecido';
        emailUsuario = emailSalvo;
      });
    }

    String? caminhoImagem = prefs.getString('imagemPerfil');
    if (!mounted) return;
    if (caminhoImagem != null) {
      setState(() {
        imagemPerfil = File(caminhoImagem);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo, $nomeUsuario!'),
        backgroundColor: Colors.teal,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Serviços'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(nomeUsuario),
              accountEmail: Text(emailUsuario),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    imagemPerfil != null ? FileImage(imagemPerfil!) : null,
                child:
                    imagemPerfil == null
                        ? const Icon(Icons.pets, color: Colors.teal)
                        : null,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/editarPerfil');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Agendamentos'),
              onTap: () {
                Navigator.pushNamed(context, '/AgendamentosPage');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.vaccines),
              title: const Text('Carteira de vacinação'),
              onTap: () {
                Navigator.pushNamed(context, '/vacinacao');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pushNamed(context, '/configuracoes');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}

// ===================
// Telas de Conteúdo
// ===================

class AgendamentosPage extends StatelessWidget {
  const AgendamentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.calendar_today, size: 72, color: Colors.teal),
          SizedBox(height: 20),
          Text('Agende seus serviços aqui!', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class ServicosPage extends StatelessWidget {
  const ServicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.build, size: 72, color: Colors.teal),
          SizedBox(height: 20),
          Text(
            'Escolha os serviços para seu pet!',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 72, color: Colors.teal),
          SizedBox(height: 20),
          Text('Visualize seu perfil!', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
