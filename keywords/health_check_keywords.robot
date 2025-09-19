*** Settings ***
Resource          ../base.robot
Library           RequestsLibrary
Library           BuiltIn

*** Keywords ***
Ping API
    Create Session    api    ${BASE_URL}
    ${res}=    GET On Session    api    /ping
    Should Be Equal As Integers    ${res.status_code}    201
    Log    Ping realizado com sucesso, status code: ${res.status_code}
    RETURN    ${res.status_code}