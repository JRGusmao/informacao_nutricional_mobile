import 'package:flutter/material.dart';

import 'telas/tela_lista_produtos.dart';

void main() {
  // Garante a inicialização correta das ligações do Flutter antes da execução
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AplicacaoNutricional());
}

class AplicacaoNutricional extends StatelessWidget {
  const AplicacaoNutricional({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informações Nutricionais',
      debugShowCheckedModeBanner: false,

      // Configuração do Tema Visual da Aplicação
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green.shade700,
          secondary: Colors.amber.shade700,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),

        // Estilo global para a Barra de Título (AppBar)
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Estilo global para os Cartões (Card)
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Estilo global para os Botões Elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // Tela inicial da aplicação
      home: const TelaListaProdutos(),
    );
  }
}
