*** Settings ***
Resource    ../keywords/create_booking_keywords.robot
Suite Setup    Log    Iniciando testes de criação de reservas
Suite Teardown    Log    Finalizando testes de criação de reservas

*** Test Cases ***
Criar Reserva Com Dados Padrao
    [Documentation]    Cria reserva usando dados padrão do sistema
    [Tags]    booking    create    positive    smoke
    
    ${booking_data}=    Create Default Booking Data
    ${booking_response}=    Criar Reserva    ${booking_data}
    
    Log    Reserva criada com ID: ${booking_response['bookingid']}
    Should Be True    ${booking_response['bookingid']} > 0

Criar Reserva Com Dados Customizados
    [Documentation]    Cria reserva com dados específicos
    [Tags]    booking    create    positive
    
    ${booking_data}=    Create Default Booking Data    
    ...    firstname=Maria    lastname=Silva    totalprice=250
    ...    checkin=2024-06-01    checkout=2024-06-05    additionalneeds=Wi-Fi
    
    ${booking_response}=    Criar Reserva    ${booking_data}
    Log    Reserva customizada criada: ${booking_response['bookingid']}

Criar Reserva Sem Nome
    [Documentation]    API aceita reserva sem firstname (comportamento real)
    [Tags]    booking    create    edge-case
    
    ${booking_data}=    Create Default Booking Data    firstname=${EMPTY}
    ${booking_response}=    Criar Reserva    ${booking_data}
    Log    API aceita reserva sem nome - ID: ${booking_response['bookingid']}

Criar Reserva Com Preco Negativo
    [Documentation]    API aceita preço negativo (comportamento real)
    [Tags]    booking    create    edge-case
    
    ${booking_data}=    Create Default Booking Data    totalprice=-100
    ${booking_response}=    Criar Reserva    ${booking_data}
    Log    API aceita preço negativo - ID: ${booking_response['bookingid']}

Criar Reserva Com Datas Invalidas
    [Documentation]    API aceita datas inválidas (comportamento real)
    [Tags]    booking    create    edge-case
    
    ${booking_data}=    Create Default Booking Data    
    ...    checkin=2024-06-10    checkout=2024-06-05
    ${booking_response}=    Criar Reserva    ${booking_data}
    Log    API aceita datas inválidas - ID: ${booking_response['bookingid']}

