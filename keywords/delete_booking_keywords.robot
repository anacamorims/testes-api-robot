*** Settings ***
Resource     ../base.robot
Library     BuiltIn
Library    Collections

*** Variables ***
${AUTH_URL}      ${BASE_URL}/auth
${USERNAME}      admin
${PASSWORD}      password123

*** Keywords ***
Obter Token De Autenticacao
    ${auth_data}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=    POST    ${AUTH_URL}    json=${auth_data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Get From Dictionary    ${response.json()}    token
    [Return]    ${token}

Deletar Reserva
    [Arguments]    ${booking_id}
    ${token}=    Obter Token De Autenticacao
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE    ${BASE_URL}/booking/${booking_id}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    201
    [Return]    ${response}