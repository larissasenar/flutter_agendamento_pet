# 🐾 PetCare – Aplicativo de Agendamento de Banho, Tosa e Vacinas

## 📱 Visão Geral

O **PetCare** é um aplicativo móvel desenvolvido com **Flutter**, voltado para facilitar o agendamento de serviços como **banho**, **tosa** e **vacinação** de pets. Com uma interface amigável, o app atende tanto **clientes** quanto **funcionários**, permitindo desde agendamentos simples até visualização de relatórios e carteira de vacinação dos pets.

---

## ✨ Funcionalidades

| Tela                  | Funcionalidade                                                                 |
|-----------------------|--------------------------------------------------------------------------------|
| 🔐 **Login/Cadastro** | Registro e login seguro para novos e antigos usuários                          |
| 🛁 **Serviços**        | Lista e detalhes dos serviços disponíveis                                     |
| 📅 **Agendamento**     | Seleção de serviços, data, hora e observações para o pet                      |
| 📋 **Meus Agendamentos** | Consulta, cancelamento e histórico de agendamentos                           |
| 💉 **Carteira de Vacinação** | Histórico de vacinas aplicadas e pendentes                             |
| 👤 **Perfil**          | Visualização e edição de informações pessoais                                 |
| 📊 **Relatórios (Admin)** | Estatísticas, filtros e exportação de dados para análise gerencial       |

---

## 🚀 Instalação

### ✅ Pré-requisitos

- Flutter instalado ([Guia oficial de instalação](https://docs.flutter.dev/get-started/install))
- Android Studio ou VSCode com plugin Flutter
- Emulador Android/iOS ou dispositivo físico

### 🔧 Passos para rodar o projeto

```bash
# Clone o repositório
git clone https://github.com/larissasenar/flutter_agendamento_pet.git
cd petcare-app

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

---

## 🗂️ Estrutura de Diretórios

```bash
lib/
├── main.dart                         # Ponto de entrada da aplicação
├── screens/
│   ├── login_screen.dart             # Tela de Login/Cadastro
│   ├── home_screen.dart              # Tela principal com navegação
│   ├── servicos_screen.dart          # Tela de Serviços
│   ├── agendamento_screen.dart       # Tela de Agendamento
│   ├── meus_agendamentos_screen.dart # Tela de Agendamentos do Usuário
│   ├── carteira_screen.dart          # Tela da Carteira de Vacinação
│   ├── perfil_screen.dart            # Tela de Perfil
│   └── relatorio_screen.dart         # Tela de Relatórios (para funcionários)
├── models/                           # Modelos de dados
├── services/                         # Lógica de autenticação, banco e Firestore
└── database/                         # Integração com SQLite
```

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** – Framework para desenvolvimento multiplataforma
- **Dart** – Linguagem principal do Flutter
- **SQLite** – Banco de dados local para armazenamento estruturado das informações

---

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma *issue* ou *pull request*.
