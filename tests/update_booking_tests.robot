*** Settings ***
Resource    ../keywords/update_booking_keywords.robot
Suite Setup    Log    Iniciando testes de atualização de reservas
Suite Teardown    Log    Finalizando testes de atualização de reservas

*** Test Cases ***
Atualizar Reserva Com Autenticacao
    [Documentation]    Atualiza reserva existente com token válido
    [Tags]    booking    update    positive    smoke
    
    ${token}=    Obter Token
    ${booking_id}=    Obter Primeira Reserva pelo Id
    
    ${updated_data}=    Create Default Booking Data
    ...    firstname=James    lastname=Brown    totalprice=150
    ...    checkin=2024-07-01    checkout=2024-07-05    additionalneeds=Late checkout
    
    ${updated_booking}=    Atualizar Reserva Completa    ${booking_id}    ${updated_data}    ${token}
    
    Log    Reserva atualizada com sucesso - ID: ${booking_id}
    Log    Novos dados: ${updated_booking['firstname']} ${updated_booking['lastname']}

Atualizar Reserva Sem Autenticacao
    [Documentation]    Tenta atualizar reserva sem token de autenticação
    [Tags]    booking    update    negative    security
    
    ${booking_id}=    Obter Primeira Reserva pelo Id
    ${booking_data}=    Create Default Booking Data    firstname=Unauthorized
    
    ${response}=    Atualizar Reserva Sem Autenticacao    ${booking_id}    ${booking_data}
    Log    Erro esperado: acesso negado sem autenticação

Atualizar Reserva Inexistente
    [Documentation]    Tenta atualizar reserva que não existe
    [Tags]    booking    update    negative
    
    ${token}=    Obter Token
    ${booking_data}=    Create Default Booking Data
    
    Setup API Session
    ${auth_headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Accept=application/json    
    ...    Cookie=token=${token}
    
    ${response}=    PUT On Session    api    /booking/999999    
    ...    headers=${auth_headers}    json=${booking_data}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_METHOD_NOT_ALLOWED}
    Log    Erro esperado para ID inexistente