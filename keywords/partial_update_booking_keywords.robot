*** Settings ***
Resource          ../base.robot
Library           RequestsLibrary
Library           BuiltIn
Library           Collections

*** Keywords ***
Obter Token
    ${payload}=    Create Dictionary    username=admin    password=password123
    ${res}=    POST On Session    api    /auth    json=${payload}
    Should Be Equal As Integers    ${res.status_code}    200
    ${token}=    Call Method    ${res}    json
    ${token}=    Get From Dictionary    ${token}    token
    RETURN    ${token}

Obter Primeira Reserva pelo Id
    ${res}=    GET On Session    api    /booking
    Should Be Equal As Integers    ${res.status_code}    200
    ${lista}=    Call Method    ${res}    json
    ${first_booking}=    Get From List    ${lista}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    RETURN    ${booking_id}

Atualizar Reserva Parcial
    [Arguments]    ${booking_id}    ${payload}    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    ${res}=    PATCH On Session    api    /booking/${booking_id}    headers=${headers}    json=${payload}
    Should Be Equal As Integers    ${res.status_code}    200
    ${booking}=    Call Method    ${res}    json
    RETURN    ${booking}