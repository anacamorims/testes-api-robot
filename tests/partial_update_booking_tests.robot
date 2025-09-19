*** Settings ***
Resource    ../keywords/partial_update_booking_keywords.robot

*** Test Cases ***
Testar Partial Update Booking
  Create Session    api    ${BASE_URL}
    ${token}=    Obter_Token
    ${booking_id}=    Obter Primeira Reserva pelo Id
    ${payload}=    Create Dictionary    firstname=James    lastname=Brown
    ${booking}=    Atualizar Reserva Parcial    ${booking_id}    ${payload}    ${token}
    Log    Booking atualizado: ${booking}
    Should Be Equal As Strings    ${booking['firstname']}    James
    Should Be Equal As Strings    ${booking['lastname']}     Brown