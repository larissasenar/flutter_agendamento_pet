import 'package:flutter_agendamento_pet/data/database_helper.dart';

class SignUpController {
  String? _nome;
  String? _email;
  String? _senha;
  String? _tipo;
  bool _isLoading = false;

  final _usuario = DatabaseHelper.instance;

  String? validaSenhaRepetida(String? senhaRepetida) {
    if (senhaRepetida == null || senhaRepetida.isEmpty) {
      return 'Campo obrigatório';
    } else if (senhaRepetida != _senha) {
      return 'Senhas devem ser iguais';
    }
    return null;
  }

  // Verifica se o email já está cadastrado
  Future<void> criaUsuario() async {
    if (_nome?.isNotEmpty == true &&
        _email?.isNotEmpty == true &&
        _senha?.isNotEmpty == true &&
        _tipo?.isNotEmpty == true) {
      final usuarioExistente = await _usuario.buscarUsuarioPorEmail(_email!);

      if (usuarioExistente != null) {
        throw Exception('Email já cadastrado');
      }

      await _usuario.cadastrarUsuario(_nome!, _email!, _senha!, _tipo!);
    } else {
      throw Exception('Por favor, preencha todos os campos.');
    }
  }

  void setNome(String? nome) => _nome = nome;
  void setEmail(String? email) => _email = email;
  void setSenha(String? senha) => _senha = senha;
  void setTipo(String? tipo) => _tipo = tipo;
  void setIsLoading(bool isLoading) => _isLoading = isLoading;

  String? get nome => _nome;
  String? get email => _email;
  String? get senha => _senha;
  String? get tipo => _tipo;
  bool get isLoading => _isLoading;
}
