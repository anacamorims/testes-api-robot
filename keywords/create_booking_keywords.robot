*** Settings ***
Resource     ../config/variables.robot
Resource     common_keywords.robot

*** Keywords ***
Criar Reserva
    [Arguments]    ${booking_data}
    Setup API Session
    ${response}=    POST On Session    api    /booking    headers=&{JSON_HEADERS}    json=${booking_data}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${booking_response}=    Set Variable    ${response.json()}
    
    # Validações da resposta
    Should Contain    ${booking_response}    bookingid
    Should Contain    ${booking_response}    booking
    Should Be True    ${booking_response['bookingid']} > 0
    
    # Validar dados da reserva criada
    Validate Booking Response    ${booking_response['booking']}    ${booking_data}
    
    RETURN    ${booking_response}

Criar Reserva Com Dados Invalidos
    [Arguments]    ${invalid_data}
    Setup API Session
    ${response}=    POST On Session    api    /booking    headers=&{JSON_HEADERS}    json=${invalid_data}    expected_status=any
    Should Be True    ${response.status_code} >= 400
    RETURN    ${response}