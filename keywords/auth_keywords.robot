*** Settings ***
Resource     ../base.robot
Library      Collections

*** Keywords ***
Realizar Login
    [Arguments]    ${username}    ${senha}
    ${body}=    Create Dictionary    username=${username}    password=${senha}
    ${response}=    POST    ${BASE_URL}/auth    json=${body}
    RETURN    ${response}

Obter Token
    [Arguments]    ${username}    ${senha}
    ${res}=    Realizar Login    ${username}    ${senha}
    Should Be Equal As Strings    ${res.status_code}    200
    ${json}=    Set Variable    ${res.json()}
    ${token}=    Get From Dictionary    ${json}    token
    RETURN  ${token}

