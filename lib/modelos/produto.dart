import 'informacao_nutricional.dart';
import 'receita.dart';
import 'comentarios.dart';

class Produto {
  final String id;
  final String nome;
  final String imagem;
  final String descricao;
  final InformacaoNutricional informacaoNutricional;
  final List<Receita> receitas;
  final List<Comentario> comentarios;
  int curtidas;
  bool estaCurtido;

  Produto({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.informacaoNutricional,
    required this.receitas,
    required this.comentarios,
    this.curtidas = 0,
    this.estaCurtido = false,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      imagem: json['imagem'],
      descricao: json['descricao'],
      curtidas: json['curtidas'] ?? 0,
      estaCurtido: json['estaCurtido'] ?? false,
      informacaoNutricional: InformacaoNutricional.fromJson(
        json['informacaoNutricional'],
      ),
      receitas: (json['receitas'] as List)
          .map((item) => Receita.fromJson(item))
          .toList(),
      comentarios: (json['comentarios'] as List)
          .map((item) => Comentario.fromJson(item))
          .toList(),
    );
  }
}
