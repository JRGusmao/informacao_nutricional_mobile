class Comentario {
  final String id;
  final String nomeUsuario;
  final String conteudo;
  final DateTime criadoEm;

  Comentario({
    required this.id,
    required this.nomeUsuario,
    required this.conteudo,
    required this.criadoEm,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      id: json['id'],
      nomeUsuario: json['nomeUsuario'],
      conteudo: json['conteudo'],
      criadoEm: DateTime.parse(json['criadoEm']),
    );
  }
}
