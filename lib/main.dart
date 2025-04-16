import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/core/theme.dart';
import 'package:flutter_agendamento_pet/data/database_pet.dart';
import 'package:flutter_agendamento_pet/pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabasePet.instance.database; //inicializa o banco
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
      home: SignInPage(),
    );
  }
}
