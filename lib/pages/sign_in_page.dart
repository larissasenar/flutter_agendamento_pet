import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/data/database_helper.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_logo.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart'; // IMPORTADO

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _senha;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppPetLogo(),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail, size: 24),
                          ),
                          validator:
                              (email) =>
                                  email!.isEmpty ? 'Email é obrigatório' : null,
                          onSaved: (email) => _email = email,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock, size: 24),
                          ),
                          obscureText: true,
                          validator:
                              (senha) =>
                                  senha!.isEmpty ? 'Senha é obrigatória' : null,
                          onSaved: (senha) => _senha = senha,
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: 120,
                          child: OutlinedButton(
                            onPressed: () async {
                              final form = _formKey.currentState!;
                              if (form.validate()) {
                                form.save();
                                setState(() => _isLoading = true);

                                final usuario = await DatabaseHelper.instance
                                    .buscarUsuario(_email!, _senha!);

                                setState(() => _isLoading = false);

                                if (!mounted) return; // Verificação de montagem

                                if (usuario != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Login realizado com sucesso!',
                                      ),
                                    ),
                                  );

                                  final tipoUsuario = usuario['tipo'];

                                  // SALVAR O EMAIL NO DISPOSITIVO
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('email', _email!);

                                  if (tipoUsuario == 'admin') {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/home',
                                    );
                                  } else {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/cliente',
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Email ou senha inválidos.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text('Entrar'),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: 120,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text('Cadastrar'),
                          ),
                        ),
                        SizedBox(height: 16),
                        if (kDebugMode) buildDebugButton(),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  Widget buildDebugButton() {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
        onPressed: () async {
          final usuarios = await DatabaseHelper.instance.listarUsuarios();
          print('Usuários cadastrados:');
          for (var usuario in usuarios) {
            print(
              'ID: ${usuario['id']}, Nome: ${usuario['nome']}, Email: ${usuario['email']}, Tipo: ${usuario['tipo']}',
            );
          }
        },
        child: Text('List User', style: TextStyle(color: Colors.orange)),
      ),
    );
  }
}
