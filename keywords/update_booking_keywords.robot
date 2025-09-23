*** Settings ***
Resource     ../config/variables.robot
Resource     common_keywords.robot
Resource     auth_keywords.robot

*** Keywords ***
Obter Primeira Reserva pelo Id
    ${booking_id}=    Get First Booking ID
    RETURN    ${booking_id}

Atualizar Reserva Completa
    [Arguments]    ${booking_id}    ${booking_data}    ${token}
    Setup API Session
    ${auth_headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Accept=application/json    
    ...    Cookie=token=${token}
    
    ${response}=    PUT On Session    api    /booking/${booking_id}    
    ...    headers=${auth_headers}    json=${booking_data}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${updated_booking}=    Set Variable    ${response.json()}
    
    # Validar dados atualizados
    Validate Booking Response    ${updated_booking}    ${booking_data}
    
    RETURN    ${updated_booking}

Atualizar Reserva Sem Autenticacao
    [Arguments]    ${booking_id}    ${booking_data}
    Setup API Session
    ${response}=    PUT On Session    api    /booking/${booking_id}    
    ...    headers=&{JSON_HEADERS}    json=${booking_data}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_FORBIDDEN}
    RETURN    ${response}