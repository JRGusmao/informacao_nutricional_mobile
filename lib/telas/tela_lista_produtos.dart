import 'package:flutter/material.dart';

import '../modelos/produto.dart';
import '../servicos/servico_produtos.dart';
import '../controlador/controlador_autenticacao.dart';
import 'tela_detalhe_produtos.dart';

class TelaListaProdutos extends StatefulWidget {
  const TelaListaProdutos({Key? key}) : super(key: key);

  @override
  State<TelaListaProdutos> createState() => _TelaListaProdutosState();
}

class _TelaListaProdutosState extends State<TelaListaProdutos> {
  late Future<List<Produto>> _futuroProdutos;

  @override
  void initState() {
    super.initState();
    _futuroProdutos = ServicoProdutos.carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações Nutricionais'),
        actions: [
          // Botão de Login / Logout na Tela Principal
          TextButton.icon(
            onPressed: () {
              setState(() {
                ControladorAutenticacao.alternarLogin();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ControladorAutenticacao.estaLogado
                        ? 'Sessão iniciada como ${ControladorAutenticacao.nomeUsuarioAtual}!'
                        : 'Sessão encerrada.',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(
              ControladorAutenticacao.estaLogado ? Icons.logout : Icons.login,
              color: Colors.white,
            ),
            label: Text(
              ControladorAutenticacao.estaLogado ? 'Sair' : 'Entrar',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Produto>>(
        future: _futuroProdutos,
        builder: (contexto, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os dados: ${snapshot.error}'),
            );
          }

          final produtos = snapshot.data ?? [];

          if (produtos.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: produtos.length,
            itemBuilder: (contexto, indice) {
              final produto = produtos[indice];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      contexto,
                      MaterialPageRoute(
                        builder: (_) => TelaDetalheProduto(produto: produto),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            produto.imagem,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produto.nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _construirItemResumo(
                                      '${produto.informacaoNutricional.calorias} kcal',
                                      'Calorias',
                                    ),
                                    _construirItemResumo(
                                      '${produto.informacaoNutricional.carboidratos}g',
                                      'Carb',
                                    ),
                                    _construirItemResumo(
                                      '${produto.informacaoNutricional.proteinas}g',
                                      'Prot',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            produto.estaCurtido
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: produto.estaCurtido
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              produto.estaCurtido = !produto.estaCurtido;
                              produto.estaCurtido
                                  ? produto.curtidas++
                                  : produto.curtidas--;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _construirItemResumo(String valor, String rotulo) {
    return Column(
      children: [
        Text(
          valor,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(rotulo, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
