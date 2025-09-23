*** Settings ***
Resource     ../config/variables.robot
Resource     common_keywords.robot
Resource     auth_keywords.robot

*** Keywords ***
Deletar Reserva
    [Arguments]    ${booking_id}    ${token}=${EMPTY}
    ${auth_token}=    Run Keyword If    '${token}' == '${EMPTY}'    Obter Token    ELSE    Set Variable    ${token}
    Setup API Session
    ${headers}=    Create Dictionary    Cookie=token=${auth_token}
    ${response}=    DELETE On Session    api    /booking/${booking_id}    headers=${headers}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_CREATED}
    RETURN    ${response}