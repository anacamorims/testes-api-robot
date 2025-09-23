*** Settings ***
Documentation    Suite completa de testes da API Restful Booker
Resource         ../keywords/auth_keywords.robot
Resource         ../keywords/create_booking_keywords.robot
Resource         ../keywords/get_booking_keywords.robot
Resource         ../keywords/update_booking_keywords.robot
Resource         ../keywords/delete_booking_keywords.robot

Suite Setup      Log    Iniciando suite completa de testes
Suite Teardown   Log    Finalizando suite completa de testes

*** Variables ***
${CREATED_BOOKING_ID}    ${EMPTY}

*** Test Cases ***
Fluxo Completo - Criar, Consultar, Atualizar e Deletar Reserva
    [Documentation]    Testa fluxo completo de CRUD de uma reserva
    [Tags]    integration    crud    smoke
    
    # 1. Autenticar
    ${token}=    Obter Token
    Set Suite Variable    ${TOKEN}    ${token}
    
    # 2. Criar reserva
    ${booking_data}=    Create Default Booking Data    
    ...    firstname=Integration    lastname=Test    totalprice=200
    ${booking_response}=    Criar Reserva    ${booking_data}
    Set Suite Variable    ${CREATED_BOOKING_ID}    ${booking_response['bookingid']}
    Log    Reserva criada com ID: ${CREATED_BOOKING_ID}
    
    # 3. Consultar reserva criada
    ${booking_details}=    Obter Reserva Pelo Id    ${CREATED_BOOKING_ID}
    Should Be Equal As Strings    ${booking_details['firstname']}    Integration
    Should Be Equal As Strings    ${booking_details['lastname']}     Test
    Log    Reserva consultada com sucesso
    
    # 4. Atualizar reserva
    ${updated_data}=    Create Default Booking Data    
    ...    firstname=Updated    lastname=Integration    totalprice=300
    ${updated_booking}=    Atualizar Reserva Completa    ${CREATED_BOOKING_ID}    ${updated_data}    ${TOKEN}
    Should Be Equal As Strings    ${updated_booking['firstname']}    Updated
    Log    Reserva atualizada com sucesso
    
    # 5. Deletar reserva
    Deletar Reserva    ${CREATED_BOOKING_ID}    ${TOKEN}
    Log    Reserva deletada com sucesso

Teste De Performance - Multiplas Operacoes
    [Documentation]    Testa performance com múltiplas operações simultâneas
    [Tags]    performance    stress
    
    ${token}=    Obter Token
    
    # Criar múltiplas reservas
    FOR    ${i}    IN RANGE    1    6
        ${booking_data}=    Create Default Booking Data    
        ...    firstname=Perf${i}    lastname=Test    totalprice=${i * 50}
        ${booking_response}=    Criar Reserva    ${booking_data}
        Log    Reserva ${i} criada: ${booking_response['bookingid']}
    END
    
    # Consultar lista de reservas
    ${all_bookings}=    Obter Lista De Reservas
    Should Not Be Empty    ${all_bookings}
    Log    Performance test concluído - ${all_bookings.__len__()} reservas encontradas