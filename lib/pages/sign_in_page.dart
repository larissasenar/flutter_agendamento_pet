import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/data/database_helper.dart';
import 'package:flutter_agendamento_pet/pages/sign_up/sign_up_page.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_logo.dart';
import 'package:flutter/foundation.dart'; // Import necessário para kDebugMode

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
  void initState() {
    super.initState();
  }

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
                      (email) => email!.isEmpty ? 'Email é obrigatório' : null,
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
                      (senha) => senha!.isEmpty ? 'Senha é obrigatória' : null,
                  onSaved: (senha) => _senha = senha,
                ),
                SizedBox(height: 16),
                Container(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () async {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        form.save();

                        final usuario = await DatabaseHelper.instance
                            .buscarUsuario(_email!, _senha!);

                        if (usuario != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login realizado com sucesso!'),
                            ),
                          );

                          final tipoUsuario = usuario['tipo'];

                          if (tipoUsuario == 'admin') {
                            Navigator.pushReplacementNamed(
                              context,
                              '/admin_home',
                            );
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              '/cliente_home',
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email ou senha inválidos.'),
                            ),
                          );
                        }
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
                SizedBox(height: 16),
                kDebugMode
                    ? Container(
                      width: 120,
                      child: OutlinedButton(
                        onPressed: () async {
                          final usuarios =
                              await DatabaseHelper.instance.listarUsuarios();
                          print('Usuários cadastrados:');
                          for (var usuario in usuarios) {
                            print(
                              'ID: ${usuario['id']}, Nome: ${usuario['nome']}, Email: ${usuario['email']}, Tipo: ${usuario['tipo']}',
                            );
                          }
                        },
                        child: Text(
                          'List User',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
