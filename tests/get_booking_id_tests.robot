*** Settings ***
Resource         ../keywords/get_booking_id_keywords.robot
Library          RequestsLibrary
Library          Collections


*** Test Cases ***
Obter Reserva Pelo Id
    Criar_Sessao
    ${booking_id}=    Obter Primeiro BookingId
    ${booking}=       Obter Booking Pelo Id    ${booking_id}
    Log    Reserva obtida: ${booking}