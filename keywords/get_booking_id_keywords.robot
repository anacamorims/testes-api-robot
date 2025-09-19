*** Settings ***
Resource     ../base.robot
Library           BuiltIn
Library           Collections

*** Keywords ***
Criar Sessao
    Create Session    api    ${BASE_URL}

Obter Primeiro BookingId
    ${res}=    GET On Session    api    /booking
    Should Be Equal As Integers    ${res.status_code}    200
    ${bookings}=    Call Method    ${res}    json
    ${first_booking}=    Get From List    ${bookings}    0
    ${booking_id}=       Get From Dictionary    ${first_booking}    bookingid
    RETURN    ${booking_id}

Obter Booking Pelo Id
    [Arguments]    ${booking_id}
    ${res}=    GET On Session    api    /booking/${booking_id}
    Should Be Equal As Integers    ${res.status_code}    200
    ${booking}=    Call Method    ${res}    json
    RETURN    ${booking}