*** Settings ***
Resource    ../keywords/auth_keywords.robot
Suite Setup    Log    Iniciando testes de autenticação
Suite Teardown    Log    Finalizando testes de autenticação

*** Test Cases ***
Login Valido Deve Retornar Token
    [Documentation]    Testa autenticação com credenciais válidas
    [Tags]    auth    positive    smoke
    
    ${token}=    Obter Token
    Should Not Be Empty    ${token}
    Should Match Regexp    ${token}    ^[a-zA-Z0-9]+$
    Log    Token obtido com sucesso: ${token}

Login Com Credenciais Customizadas
    [Documentation]    Testa autenticação com credenciais específicas
    [Tags]    auth    positive
    
    ${token}=    Obter Token    admin    password123
    Should Not Be Empty    ${token}
    Log    Token customizado obtido: ${token}

Login Invalido Deve Retornar Erro
    [Documentation]    Testa autenticação com senha inválida
    [Tags]    auth    negative
    
    Obter Token Invalido    admin    senhaInvalida

Login Com Usuario Invalido
    [Documentation]    Testa autenticação com usuário inválido
    [Tags]    auth    negative
    
    Obter Token Invalido    usuarioInvalido    password123

Login Sem Credenciais
    [Documentation]    Testa autenticação sem fornecer credenciais
    [Tags]    auth    negative    edge-case
    
    Obter Token Invalido    ${EMPTY}    ${EMPTY}
