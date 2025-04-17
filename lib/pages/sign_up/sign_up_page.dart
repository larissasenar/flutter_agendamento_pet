import 'package:flutter/material.dart';
import 'package:flutter_agendamento_pet/pages/sign_up/sign_up_controller.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_loading.dart';
import 'package:flutter_agendamento_pet/widgets/app_pet_logo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child:
                _controller.isLoading
                    ? Center(child: AppPetLoading())
                    : Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppPetLogo(),
                          SizedBox(height: 20),
                          Text(
                            "Cadastre-se e tenha acesso a serviços exclusivos para o seu pet!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
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
                            onSaved: (nome) => _controller.setNome(nome),
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
                              if (!email.contains('@') ||
                                  !email.contains('.')) {
                                return 'Email inválido.';
                              }
                              return null;
                            },
                            onSaved: (email) => _controller.setEmail(email),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: Icon(Icons.lock, size: 24),
                            ),
                            obscureText: true,
                            onChanged: _controller.setSenha,
                            validator: (senha) {
                              if (senha!.isEmpty) {
                                return 'A senha é obrigatória.';
                              }
                              if (senha.length < 8) {
                                return 'A senha deve ter pelo menos 8 caracteres.';
                              }
                              return null;
                            },
                            onSaved: (senha) => _controller.setSenha(senha),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Repita a Senha',
                              prefixIcon: Icon(Icons.lock, size: 24),
                            ),
                            obscureText: true,
                            validator:
                                (senhaRepetida) => _controller
                                    .validaSenhaRepetida(senhaRepetida),
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: 'cliente',
                            items:
                                ['cliente', 'admin'].map((tipo) {
                                  return DropdownMenuItem(
                                    value: tipo,
                                    child: Text(tipo.toUpperCase()),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              _controller.setTipo(value);
                            },
                            onSaved: (value) {
                              _controller.setTipo(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Tipo de usuário',
                            ),
                          ),

                          SizedBox(height: 24),
                          Container(
                            width: 120,
                            child: OutlinedButton(
                              onPressed: () async {
                                final form = _formKey.currentState!;
                                if (form.validate()) {
                                  form.save();
                                  setState(() {
                                    _controller.setIsLoading(true);
                                  });
                                  try {
                                    await _controller.criaUsuario();
                                    //setState(() { _controller.setIsLoading(false); });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Cadastro realizado com sucesso!',
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e is Exception
                                              ? e.toString().replaceFirst(
                                                'Exception: ',
                                                '',
                                              )
                                              : 'Erro desconhecido',
                                        ),
                                      ),
                                    );
                                  }
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
}
