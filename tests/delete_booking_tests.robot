*** Settings ***
Resource    ../keywords/delete_booking_keywords.robot
Resource    ../keywords/auth_keywords.robot
Resource    ../keywords/common_keywords.robot

*** Test Cases ***
Deletar Reserva Existente
    Create Session    api    ${BASE_URL}
    ${bookings}=    GET    ${BASE_URL}/booking
    ${first_booking}=    Get From List    ${bookings.json()}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    ${response}=    Deletar Reserva    ${booking_id}
    Should Be Equal As Integers    ${response.status_code}    201

Deletar Reserva Inexistente
    Setup API Session
    ${token}=    Obter Token
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE On Session    api    /booking/999999    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_METHOD_NOT_ALLOWED}
    Log    API retorna 405 para ID inexistente (comportamento esperado)
