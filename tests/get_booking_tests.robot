*** Settings ***
Resource    ../keywords/get_booking_keywords.robot
Resource    ../keywords/create_booking_keywords.robot
Suite Setup    Log    Iniciando testes de consulta de reservas
Suite Teardown    Log    Finalizando testes de consulta de reservas

*** Test Cases ***
Obter Lista De Todas As Reservas
    [Documentation]    Obtém lista completa de reservas
    [Tags]    booking    get    positive    smoke
    
    ${bookings}=    Obter Lista De Reservas
    Should Not Be Empty    ${bookings}
    Log    Total de reservas encontradas: ${bookings.__len__()}

Obter Reserva Por ID Valido
    [Documentation]    Obtém detalhes de uma reserva específica
    [Tags]    booking    get    positive
    
    ${booking_id}=    Get First Booking ID
    ${booking}=    Obter Reserva Pelo Id    ${booking_id}
    
    Log    Reserva obtida - ID: ${booking_id}
    Log    Nome: ${booking['firstname']} ${booking['lastname']}
    Log    Preço: ${booking['totalprice']}

Obter Nome Do Reservista
    [Documentation]    Extrai nome completo do reservista
    [Tags]    booking    get    positive
    
    ${booking_id}=    Get First Booking ID
    ${firstname}    ${lastname}=    Obter Nome Do Reservista    ${booking_id}
    
    Log    Nome completo: ${firstname} ${lastname}
    Should Not Be Empty    ${firstname}
    Should Not Be Empty    ${lastname}

Filtrar Reservas Por Nome
    [Documentation]    Filtra reservas por firstname
    [Tags]    booking    get    filter    positive
    
    # Primeiro cria uma reserva para garantir que existe
    ${booking_data}=    Create Default Booking Data    firstname=TestUser
    ${new_booking}=    Criar Reserva    ${booking_data}
    
    # Depois filtra por esse nome
    ${filtered_bookings}=    Obter Lista De Reservas    firstname=TestUser
    Should Not Be Empty    ${filtered_bookings}
    Log    Reservas filtradas por nome: ${filtered_bookings.__len__()}

Obter Reserva Com ID Inexistente
    [Documentation]    Tenta obter reserva com ID que não existe
    [Tags]    booking    get    negative
    
    Setup API Session
    ${response}=    GET On Session    api    /booking/999999    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_NOT_FOUND}
    Log    Erro esperado para ID inexistente