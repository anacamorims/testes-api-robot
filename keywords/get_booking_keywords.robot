*** Settings ***
Resource     ../config/variables.robot
Resource     common_keywords.robot

*** Keywords ***
Obter Reserva Pelo Id
    [Arguments]    ${booking_id}
    Setup API Session
    ${response}=    GET On Session    api    /booking/${booking_id}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${booking}=    Set Variable    ${response.json()}
    
    # Validações básicas da estrutura
    Should Contain    ${booking}    firstname
    Should Contain    ${booking}    lastname
    Should Contain    ${booking}    totalprice
    Should Contain    ${booking}    depositpaid
    Should Contain    ${booking}    bookingdates
    Should Contain    ${booking['bookingdates']}    checkin
    Should Contain    ${booking['bookingdates']}    checkout
    
    RETURN    ${booking}

Obter Nome Do Reservista
    [Arguments]    ${booking_id}
    ${booking}=    Obter Reserva Pelo Id    ${booking_id}
    ${firstname}=    Get From Dictionary    ${booking}    firstname
    ${lastname}=     Get From Dictionary    ${booking}    lastname
    Should Not Be Empty    ${firstname}
    Should Not Be Empty    ${lastname}
    RETURN    ${firstname}    ${lastname}

Obter Lista De Reservas
    [Arguments]    ${firstname}=${EMPTY}    ${lastname}=${EMPTY}    ${checkin}=${EMPTY}    ${checkout}=${EMPTY}
    Setup API Session
    ${params}=    Create Dictionary
    Run Keyword If    '${firstname}' != '${EMPTY}'    Set To Dictionary    ${params}    firstname=${firstname}
    Run Keyword If    '${lastname}' != '${EMPTY}'     Set To Dictionary    ${params}    lastname=${lastname}
    Run Keyword If    '${checkin}' != '${EMPTY}'      Set To Dictionary    ${params}    checkin=${checkin}
    Run Keyword If    '${checkout}' != '${EMPTY}'     Set To Dictionary    ${params}    checkout=${checkout}
    
    ${response}=    GET On Session    api    /booking    params=${params}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${bookings}=    Set Variable    ${response.json()}
    RETURN    ${bookings}