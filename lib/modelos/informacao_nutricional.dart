class InformacaoNutricional {
  final double calorias;
  final double carboidratos;
  final double proteinas;
  final double gorduras;
  final double fibras;
  final double sodio;
  final Map<String, String>? vitaminas;

  InformacaoNutricional({
    required this.calorias,
    required this.carboidratos,
    required this.proteinas,
    required this.gorduras,
    required this.fibras,
    required this.sodio,
    this.vitaminas,
  });

  factory InformacaoNutricional.fromJson(Map<String, dynamic> json) {
    return InformacaoNutricional(
      calorias: (json['calorias'] as num).toDouble(),
      carboidratos: (json['carboidratos'] as num).toDouble(),
      proteinas: (json['proteinas'] as num).toDouble(),
      gorduras: (json['gorduras'] as num).toDouble(),
      fibras: (json['fibras'] as num).toDouble(),
      sodio: (json['sodio'] as num).toDouble(),
      vitaminas: json['vitaminas'] != null
          ? Map<String, String>.from(json['vitaminas'])
          : null,
    );
  }
}
