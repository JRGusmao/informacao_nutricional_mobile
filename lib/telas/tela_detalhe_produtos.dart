import 'package:flutter/material.dart';

import '../modelos/produto.dart';
import '../modelos/comentarios.dart';
import '../controlador/controlador_autenticacao.dart';

class TelaDetalheProduto extends StatefulWidget {
  final Produto produto;

  const TelaDetalheProduto({Key? key, required this.produto}) : super(key: key);

  @override
  State<TelaDetalheProduto> createState() => _TelaDetalheProdutoState();
}

class _TelaDetalheProdutoState extends State<TelaDetalheProduto> {
  final TextEditingController _controladorTextoComentario =
      TextEditingController();

  @override
  void dispose() {
    _controladorTextoComentario.dispose();
    super.dispose();
  }

  void _adicionarComentario() {
    final texto = _controladorTextoComentario.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      widget.produto.comentarios.add(
        Comentario(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nomeUsuario: ControladorAutenticacao.nomeUsuarioAtual,
          conteudo: texto,
          criadoEm: DateTime.now(),
        ),
      );
      _controladorTextoComentario.clear();
    });

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comentário publicado com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _alternarCurtida() {
    setState(() {
      widget.produto.estaCurtido = !widget.produto.estaCurtido;
      if (widget.produto.estaCurtido) {
        widget.produto.curtidas++;
      } else {
        widget.produto.curtidas--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.produto.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _construirCabecalho(context),
            const Divider(height: 32),
            _construirTabelaNutricional(),
            const Divider(height: 32),
            _construirSecaoReceitas(),
            const Divider(height: 32),
            _construirSecaoComentarios(),
          ],
        ),
      ),
    );
  }

  // --- MÉTODOS MODULARES DE CONSTRUÇÃO DE INTERFACE ---

  Widget _construirCabecalho(BuildContext contexto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            widget.produto.imagem,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: Colors.grey.shade300,
              child: const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.produto.nome,
                style: Theme.of(contexto).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    widget.produto.estaCurtido
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.produto.estaCurtido
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: _alternarCurtida,
                ),
                Text(
                  '${widget.produto.curtidas}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.produto.descricao,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
        ),
      ],
    );
  }

  Widget _construirTabelaNutricional() {
    final info = widget.produto.informacaoNutricional;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tabela Nutricional Completa (por 100g)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            _construirLinhaTabela('Calorias', '${info.calorias} kcal'),
            _construirLinhaTabela('Carboidratos', '${info.carboidratos} g'),
            _construirLinhaTabela('Proteínas', '${info.proteinas} g'),
            _construirLinhaTabela('Gorduras Totais', '${info.gorduras} g'),
            _construirLinhaTabela('Fibras Alimentares', '${info.fibras} g'),
            _construirLinhaTabela('Sódio', '${info.sodio} mg'),
            if (info.vitaminas != null)
              ...info.vitaminas!.entries.map(
                (item) => _construirLinhaTabela(item.key, item.value),
              ),
          ],
        ),
      ],
    );
  }

  TableRow _construirLinhaTabela(String rotulo, String valor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            rotulo,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(valor, textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _construirSecaoReceitas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Receitas Sugeridas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (widget.produto.receitas.isEmpty)
          const Text(
            'Nenhuma receita cadastrada para este produto.',
            style: TextStyle(color: Colors.grey),
          )
        else
          ...widget.produto.receitas.map(
            (receita) => Card(
              color: Colors.green.shade50,
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            receita.titulo,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              receita.tempoPreparo,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ingredientes:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    ...receita.ingredientes.map(
                      (ingrediente) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                        child: Text('• $ingrediente'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Modo de Preparo:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    ...receita.instrucoes.asMap().entries.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                        child: Text('${item.key + 1}. ${item.value}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _construirSecaoComentarios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comentários da Comunidade',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ControladorAutenticacao.estaLogado
            ? _construirCampoEnvioComentario()
            : _construirAvisoLogin(),
        const SizedBox(height: 16),
        _construirListaComentarios(),
      ],
    );
  }

  Widget _construirCampoEnvioComentario() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controladorTextoComentario,
            decoration: InputDecoration(
              labelText: 'Escreva um comentário...',
              hintText: 'O que achou deste alimento?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.send_rounded, color: Colors.green),
          onPressed: _adicionarComentario,
        ),
      ],
    );
  }

  Widget _construirAvisoLogin() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.lock_outline, color: Colors.amber),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Faça login na tela inicial para publicar um comentário.',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirListaComentarios() {
    if (widget.produto.comentarios.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Nenhum comentário ainda. Seja o primeiro a comentar!',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.produto.comentarios.length,
      separatorBuilder: (_, __) => const Divider(height: 16),
      itemBuilder: (contexto, indice) {
        final comentario = widget.produto.comentarios[indice];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Text(
              comentario.nomeUsuario.isNotEmpty
                  ? comentario.nomeUsuario[0].toUpperCase()
                  : 'U',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            comentario.nomeUsuario,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              comentario.conteudo,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
