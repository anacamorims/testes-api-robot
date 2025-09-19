*** Settings ***
Resource          ../base.robot
Library           BuiltIn
Library           Collections

*** Keywords ***
Criar Sessao
    Create Session    api    ${BASE_URL}

Obter Reserva Pelo Id
    [Arguments]    ${booking_id}
    ${res}=    GET On Session    api    /booking/${booking_id}
    Should Be Equal As Integers    ${res.status_code}    200
    ${booking}=    Call Method    ${res}    json
    RETURN    ${booking}

Obter Nome Do Reservista
    [Arguments]    ${booking_id}
    ${booking}=    Obter Reserva Pelo Id    ${booking_id}
    ${firstname}=    Get From Dictionary    ${booking}    firstname
    ${lastname}=     Get From Dictionary    ${booking}    lastname
    RETURN    ${firstname}    ${lastname}