import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_logo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _email;
  String? _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppPetLogo(),
                  Text(
                    "Cadastre-se e tenha acesso a serviços exclusivos para o seu pet!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person, size: 24),
                    ),
                    validator:
                        (nome) =>
                            nome!.isEmpty
                                ? 'Por favor, informe seu nome.'
                                : null,
                    onSaved: (nome) => _nome = nome,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail, size: 24),
                    ),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Por favor, informe um email válido.';
                      }
                      if (!email.contains('@') || !email.contains('.')) {
                        return 'Email inválido.';
                      }
                      return null;
                    },
                    onSaved: (email) => _email = email,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock, size: 24),
                    ),
                    obscureText: true,
                    onChanged: (senha) => _senha = senha,
                    validator: (senha) {
                      if (senha!.isEmpty) {
                        return 'A senha é obrigatória.';
                      }
                      if (senha.length < 8) {
                        return 'A senha deve ter pelo menos 8 caracteres.';
                      }
                      return null;
                    },
                    onSaved: (senha) => _senha = senha,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Repita a Senha',
                      prefixIcon: Icon(Icons.lock, size: 24),
                    ),
                    obscureText: true,
                    validator:
                        (senhaRepetida) => validaSenhaRepetida(senhaRepetida),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        final form = _formKey.currentState!;
                        if (form.validate()) {
                          form.save(); // Salva os dados do formulário
                          print('Nome: $_nome');
                          print('Email: $_email');
                          print('Senha: $_senha');
                        }
                      },
                      child: Text('Confirmar'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Voltar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validaSenhaRepetida(String? senhaRepetida) {
    if (senhaRepetida!.isEmpty) {
      return 'Campo obrigatorio';
    } else if (senhaRepetida != _senha) {
      return 'Senhas devem ser iguais';
    }
    return null;
  }
}
