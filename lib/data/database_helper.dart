import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('usuarios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Atualize a versão para forçar uma recriação
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Aqui é onde você garante que, quando a versão mudar, a tabela será recriada
          await db.execute("DROP TABLE IF EXISTS usuarios");
          await _createDB(db, newVersion);
        }
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL,
        tipo TEXT NOT NULL
      )
    ''');
  }

  Future<int> cadastrarUsuario(
    String nome,
    String email,
    String senha,
    String tipo,
  ) async {
    final db = await instance.database;
    return await db.insert('usuarios', {
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
    });
  }

  Future<Map<String, dynamic>?> buscarUsuario(
    String email,
    String senha,
  ) async {
    final db = await instance.database;

    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  // Buscar usuário por email (para verificar se já existe)
  Future<Map<String, dynamic>?> buscarUsuarioPorEmail(String email) async {
    final db = await instance.database;

    final result = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first; // Retorna o primeiro usuário encontrado
    } else {
      return null; // Retorna null se não encontrar nenhum usuário com esse email
    }
  }

  // Listar usuários (exemplo para debug)
  Future<List<Map<String, dynamic>>> listarUsuarios() async {
    final db = await instance.database;
    return await db.query('usuarios');
  }
}
