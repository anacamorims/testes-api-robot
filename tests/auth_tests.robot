*** Settings ***
Resource    ../keywords/auth_keywords.robot
Library    Collections

*** Test Cases ***
Login Valido Deve Retornar Token
    ${token}=    Obter Token    admin    password123
    ${message}=    Set Variable    Token obtido: ${token}
    Log    ${message}

Login Invalido Deve Retornar Erro
    ${res}=    Realizar Login    admin    password123556
    ${body}=   To Json    ${res.content}
    Should Be Equal As Strings    ${body["reason"]}    Bad credentials
