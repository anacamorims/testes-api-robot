*** Settings ***
Resource    ../keywords/delete_booking_keywords.robot
Library          RequestsLibrary

*** Test Cases ***
Deletar Reserva Existente
    Create Session    api    ${BASE_URL}
    ${bookings}=    GET    ${BASE_URL}/booking
    ${first_booking}=    Get From List    ${bookings.json()}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    ${response}=    Deletar Reserva    ${booking_id}
    Should Be Equal As Integers    ${response.status_code}    201

Deletar Reserva Inexistente
    Create Session    api    ${BASE_URL}
    ${response}=    Deletar Reserva    2
    Should Be Equal As Integers    ${response.status_code}    201
