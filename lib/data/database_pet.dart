import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pet.dart';
import '../models/agendamento.dart';

class DatabasePet {
  static Database? _database;
  static final DatabasePet instance = DatabasePet._internal();

  factory DatabasePet() => instance;

  DatabasePet._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase(); //inicializamos o banco de dados chamando
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(
      documentsDirectory.path,
      'agendamento_pet.db',
    ); //cria, se não existir, o banco de dados
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  //_createDb(): É chamada apenas na primeira vez que o banco de dados é criado.
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        raca TEXT NOT NULL,
        idade INTEGER NOT NULL,
        nomeDono TEXT NOT NULL,
        telefoneDono TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE agendamentos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        petId INTEGER NOT NULL,
        dataHora TEXT NOT NULL,
        servico TEXT NOT NULL,
        observacoes TEXT,
        FOREIGN KEY (petId) REFERENCES pets(id)
      )
    ''');
  }

  // Métodos para interagir com a tabela de Pets
  Future<int> insertPet(Pet pet) async {
    final db = await database;
    return await db.insert('pets', pet.toMap());
  }

  Future<List<Pet>> getAllPets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pets');
    return List.generate(maps.length, (i) {
      return Pet.fromMap(maps[i]);
    });
  }

  // Adicione outros métodos para Pets (update, delete, getById, etc.)

  // Métodos para interagir com a tabela de Agendamentos
  Future<int> insertAgendamento(Agendamento agendamento) async {
    final db = await database;
    return await db.insert('agendamentos', agendamento.toMap());
  }

  Future<List<Agendamento>> getAllAgendamentos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('agendamentos');
    return List.generate(maps.length, (i) {
      return Agendamento.fromMap(maps[i]);
    });
  }

  // métodos para agendamentos (update, delete)
}
