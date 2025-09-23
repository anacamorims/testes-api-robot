# Testes API Restful Booker com Robot Framework

Este projeto contém testes automatizados para a API [Restful Booker](https://restful-booker.herokuapp.com) utilizando **Robot Framework**.

## 🚀 Melhorias Implementadas

- ✅ **Configuração centralizada** - Variáveis em `config/variables.robot`
- ✅ **Keywords reutilizáveis** - Funções comuns em `keywords/common_keywords.robot`
- ✅ **Testes robustos** - Casos positivos, negativos e edge cases
- ✅ **Validações completas** - Verificações de estrutura e dados
- ✅ **Tags organizadas** - Classificação por tipo e prioridade
- ✅ **Suite integrada** - Testes de fluxo completo CRUD
- ✅ **Tratamento de erros** - Validação de status codes e respostas
- ✅ **Documentação** - Descrições claras em todos os testes

## 📋 Pré-requisitos

- Python 3.10+
- Robot Framework
- RequestsLibrary

## 🔧 Instalação

```bash
# Instalar dependências
pip install -r requirements.txt

# Ou instalação manual
pip install robotframework==6.1.1
pip install robotframework-requests==0.9.4
```

## 🏃‍♂️ Executando os Testes

### Opção 1: Script automatizado (Windows)
```bash
run_tests.bat
```

### Opção 2: Comandos manuais
```bash
# Todos os testes
robot --outputdir reports tests/

# Apenas testes smoke
robot --include smoke --outputdir reports tests/

# Suite completa (integração)
robot --outputdir reports tests/suite_completa.robot

# Testes por categoria
robot --include positive --outputdir reports tests/
robot --include negative --outputdir reports tests/
```

## 📁 Estrutura do Projeto

```
booking-api-robot/
├── config/
│   └── variables.robot          # Configurações centralizadas
├── keywords/
│   ├── common_keywords.robot     # Keywords reutilizáveis
│   ├── auth_keywords.robot       # Autenticação
│   ├── create_booking_keywords.robot
│   ├── get_booking_keywords.robot
│   ├── update_booking_keywords.robot
│   └── delete_booking_keywords.robot
├── tests/
│   ├── auth_tests.robot          # Testes de autenticação
│   ├── create_booking_tests.robot
│   ├── get_booking_tests.robot
│   ├── update_booking_tests.robot
│   ├── delete_booking_tests.robot
│   └── suite_completa.robot      # Testes integrados
├── reports/                      # Relatórios gerados
├── requirements.txt              # Dependências
└── run_tests.bat                # Script de execução
```

## 🏷️ Tags Disponíveis

- `smoke` - Testes essenciais
- `positive` - Casos de sucesso
- `negative` - Casos de erro
- `edge-case` - Casos extremos
- `integration` - Testes integrados
- `security` - Testes de segurança
- `performance` - Testes de performance

## 📊 Relatórios

Após a execução, os relatórios ficam disponíveis em:
- `reports/report.html` - Relatório principal
- `reports/log.html` - Log detalhado
- `reports/output.xml` - Dados estruturados

---

Projeto desenvolvido como atividade para o estágio em QA da Compass UOL.