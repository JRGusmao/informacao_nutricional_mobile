class Receita {
  final String titulo;
  final String tempoPreparo;
  final List<String> ingredientes;
  final List<String> instrucoes;

  Receita({
    required this.titulo,
    required this.tempoPreparo,
    required this.ingredientes,
    required this.instrucoes,
  });

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      titulo: json['titulo'],
      tempoPreparo: json['tempoPreparo'],
      ingredientes: List<String>.from(json['ingredientes']),
      instrucoes: List<String>.from(json['instrucoes']),
    );
  }
}
