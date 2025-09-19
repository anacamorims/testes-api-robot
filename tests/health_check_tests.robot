*** Settings ***
Resource    ../keywords/health_check_keywords.robot

*** Test Cases ***
Ping API
    ${status}=    Ping_API
    Log    Status do ping: ${status}
    Should Be Equal As Integers    ${status}    201