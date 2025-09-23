*** Settings ***
Resource     ../config/variables.robot
Resource     common_keywords.robot
Library      Collections

*** Keywords ***
Realizar Login
    [Arguments]    ${username}=${ADMIN_USERNAME}    ${password}=${ADMIN_PASSWORD}
    Setup API Session
    ${credentials}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    POST On Session    api    /auth    json=${credentials}    headers=&{JSON_HEADERS}
    RETURN    ${response}

Obter Token
    [Arguments]    ${username}=${ADMIN_USERNAME}    ${password}=${ADMIN_PASSWORD}
    ${response}=    Realizar Login    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${token_data}=    Set Variable    ${response.json()}
    ${token}=    Get From Dictionary    ${token_data}    token
    Should Not Be Empty    ${token}
    RETURN    ${token}

Obter Token Invalido
    [Arguments]    ${username}    ${password}
    ${response}=    Realizar Login    ${username}    ${password}
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${error_data}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${error_data['reason']}    Bad credentials
    RETURN    ${response}

