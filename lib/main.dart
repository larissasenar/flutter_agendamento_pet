import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/core/theme.dart';
import 'package:flutter_agendamento_pet/data/database_helper.dart';

// Páginas principais
import 'package:flutter_agendamento_pet/pages/sign_in_page.dart';
import 'package:flutter_agendamento_pet/pages/sign_up/sign_up_page.dart';
import 'package:flutter_agendamento_pet/pages/home_page/home_page.dart';
import 'package:flutter_agendamento_pet/pages/cliente_home_page/cliente_home_page.dart';
import 'package:flutter_agendamento_pet/pages/cliente_home_page/vacinacao_page.dart';
import 'package:flutter_agendamento_pet/pages/cliente_home_page/editar_perfil_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database; // Inicializa o banco de dados
  runApp(const AgendamentoPetApp());
}

class AgendamentoPetApp extends StatelessWidget {
  const AgendamentoPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento Pet App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/cliente': (context) => ClienteHomePage(),
        '/vacinacao': (context) => VacinacaoPage(),
        '/servicos': (context) => ServicosPage(),
        '/agendamentos': (context) => AgendamentosPage(),
        '/perfil': (context) => PerfilPage(),
        '/editarPerfil':
            (context) =>
                EditarPerfilPage(), // igual ao usado na ClienteHomePage
      },
    );
  }
}
