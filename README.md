# Informação Nutricional 🥗

O **Informação Nutricional** é uma aplicação desenvolvida em Flutter que faz parte do módulo de nutrição (`nutricao/informacao_nutricional`). O seu objetivo principal é disponibilizar dados sobre alimentos, tabelas nutricionais e suporte ao acompanhamento de dietas e hábitos saudáveis.

Desenvolvido por João Ricardo Gusmão

**Disciplina:** Programação Movél

**Semestre:** 2026.2

## 🚀 Funcionalidades

- **Consulta de Alimentos:** Pesquisa rápida de tabelas nutricionais (calorias, macronutrientes e micronutrientes).
- **Gestão de Perfil Nutricional:** Registo de informações pessoais para cálculo de metas diárias.
- **Histórico e Registo Diário:** Acompanhamento do consumo diário de alimentos.
- **Suporte Multiplataforma:** Suporte para dispositivos móveis e execução em ambiente web/Chrome.

---

## 🛠️ Tecnologias Utilizadas

- **[Flutter](https://flutter.dev/):** Framework para desenvolvimento do front-end cross-platform.
- **[Dart](https://dart.dev/):** Linguagem de programação principal do projeto.
- **Flutter Web / Chrome Device:** Configuração e suporte para testes em navegador.

---

## 📁 Estrutura do Projeto

A estrutura de diretórios do módulo `nutricao/informacao_nutricional` organiza-se da seguinte forma:

```text
nutricao/
└── informacao_nutricional/
    ├── .dart_tool/              # Ferramentas e configurações de compilação do Dart/Flutter
    ├── android/                 # Ficheiros nativos da plataforma Android
    ├── ios/                     # Ficheiros nativos da plataforma iOS
    ├── assets/                  # Ficheiros com os assests do projeto
    ├── lib/                     # Código-fonte principal da aplicação (Dart)
    │   ├── main.dart            # Ponto de entrada da aplicação
    │   ├── models/              # Modelos de dados nutricionais
    │   ├── screens/             # Telas e interface do utilizador
    │   └── services/            # Serviços de integração e consumo de dados
    ├── web/                     # Configurações para execução em ambiente Web
    └── pubspec.yaml             # Configuração de dependências do Flutter

```

---

## 🔧 Pré-requisitos

Antes de iniciar, certifique-se de que tem instalado na sua máquina:

- **Flutter SDK** (Versão estável recomendada)
- **Dart SDK**
- **Android Studio** ou **VS Code** com as extensões do Flutter e Dart instaladas
- Navegador **Google Chrome** (para testes em web)

---

## 🚀 Como Executar o Projeto

1. **Clonar o repositório:**

```bash
git clone https://github.com/JRGusmao/informacao_nutricional_mobile.git

```

2. **Navegar para a pasta do projeto:**

```bash
cd nutricao/informacao_nutricional

```

3. **Instalar as dependências:**

```bash
flutter pub get

```

4. **Apagar a pasta com o cache do android**

```bash
Remove-Item -Recurse -Force android

```

5. **Recriar a pasta `android` com o Flutter**

```bash
flutter create --platforms=android .

```

6. **Executar a aplicação:**

- _Em dispositivo móvel (Emulador ou Físico):_

```bash
flutter run

```

- _No navegador (Chrome):_

```bash
flutter run -d chrome

```

## 📄 Licença

Este projeto está sob a licença MIT. Consulte o ficheiro `LICENSE` para mais detalhes.
