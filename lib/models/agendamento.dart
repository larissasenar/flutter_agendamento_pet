class Agendamento {
  int? id;
  int petId;
  DateTime dataHora;
  String servico;
  String? observacoes;

  Agendamento({
    this.id,
    required this.petId,
    required this.dataHora,
    required this.servico,
    this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petId': petId,
      'dataHora': dataHora.toIso8601String(), // Salva a data e hora como String
      'servico': servico,
      'observacoes': observacoes,
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'],
      petId: map['petId'],
      dataHora: DateTime.parse(
        map['dataHora'],
      ), // Converte a String de volta para DateTime
      servico: map['servico'],
      observacoes: map['observacoes'],
    );
  }
}
