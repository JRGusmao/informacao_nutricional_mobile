class ControladorAutenticacao {
  // Simulação do estado de autenticação do usuário
  static bool estaLogado = false;
  static String nomeUsuarioAtual = "Usuario Teste";

  static void alternarLogin() {
    estaLogado = !estaLogado;
  }
}
