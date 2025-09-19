*** Settings ***
Resource     ../base.robot

*** Keywords ***
Criar Reserva
    [Arguments]    ${payload}
    Create Session    api    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${res}=    POST On Session    api    /booking    headers=${headers}    json=${payload}
    Should Be Equal As Integers    ${res.status_code}    200
    ${booking}=    Call Method    ${res}    json
    RETURN    ${booking}