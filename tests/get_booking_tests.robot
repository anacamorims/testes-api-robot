*** Settings ***
Resource        ../keywords/get_booking_keywords.robot
Library         RequestsLibrary

*** Test Cases ***
Obter Reserva Completa
    Criar Sessao
    ${bookings}=    GET On Session    api    /booking
    Should Be Equal As Integers    ${bookings.status_code}    200
    ${lista}=    Call Method    ${bookings}    json
    ${first_booking}=    Get From List    ${lista}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    ${booking}=       Obter Reserva Pelo Id    ${booking_id}
    Log    Booking obtido: ${booking}
    Should Contain    ${booking}    firstname
    Should Contain    ${booking}    lastname
    Should Contain    ${booking}    bookingdates

Obter Nome Do Reservista
    Criar Sessao
    ${bookings}=    GET On Session    api    /booking
    Should Be Equal As Integers    ${bookings.status_code}    200
    ${lista}=    Call Method    ${bookings}    json
    ${first_booking}=    Get From List    ${lista}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    ${firstname}    ${lastname}=    Obter Nome Do Reservista   ${booking_id}
    Log    Nome completo do reservista: ${firstname} ${lastname}
    Should Not Be Empty    ${firstname}
    Should Not Be Empty    ${lastname}