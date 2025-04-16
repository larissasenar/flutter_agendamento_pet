class Pet {
  int? id;
  String nome;
  String raca;
  int idade;
  String nomeDono;
  String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.idade,
    required this.nomeDono,
    required this.telefoneDono,
  });

  // Converte um objeto Pet para um Map (útil para salvar no SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'raca': raca,
      'idade': idade,
      'nomeDono': nomeDono,
      'telefoneDono': telefoneDono,
    };
  }

  // Cria um objeto Pet a partir de um Map (útil para ler do SQLite)
  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      nome: map['nome'],
      raca: map['raca'],
      idade: map['idade'],
      nomeDono: map['nomeDono'],
      telefoneDono: map['telefoneDono'],
    );
  }
}
