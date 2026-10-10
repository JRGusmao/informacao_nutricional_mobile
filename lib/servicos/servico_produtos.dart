import 'dart:convert';

import 'package:flutter/services.dart';

import '../modelos/produto.dart';

class ServicoProdutos {
  static Future<List<Produto>> carregarProdutos() async {
    final String resposta = await rootBundle.loadString(
      'assets/dados/produtos.json',
    );
    final List<dynamic> dados = jsonDecode(resposta);
    return dados.map((json) => Produto.fromJson(json)).toList();
  }
}
