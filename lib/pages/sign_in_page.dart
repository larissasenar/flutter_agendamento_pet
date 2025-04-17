import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/pages/sign_up_page.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_logo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppPetLogo(), //(isAdmin: true),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail, size: 24),
                  ),
                  validator:
                      (email) =>
                          email!.isEmpty ? 'Email é obrigatório' : null,
                  onSaved: (email) => _email = email,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.mail, size: 24),
                  ),
                  obscureText: true,
                  validator:
                      (senha) =>
                          senha!.isEmpty ? 'Senha é obrigatória' : null,
                  onSaved: (senha) => _senha = senha,
                ),
                SizedBox(height: 16),
                Container(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        form.save(); // Salva os dados do formulário
                        print('Email: $_email');
                        print('Senha: $_senha');
                      }
                    },
                    child: Text('Entrar'),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => SignUpPage()));
                    },
                    child: Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
