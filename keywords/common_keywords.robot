*** Settings ***
Resource    ../config/variables.robot
Library     RequestsLibrary
Library     Collections

*** Keywords ***
Setup API Session
    Create Session    api    ${BASE_URL}    timeout=${API_TIMEOUT}

Create Default Booking Data
    [Arguments]    ${firstname}=${DEFAULT_FIRSTNAME}    ${lastname}=${DEFAULT_LASTNAME}    
    ...           ${totalprice}=${DEFAULT_TOTALPRICE}    ${depositpaid}=${DEFAULT_DEPOSITPAID}
    ...           ${checkin}=${DEFAULT_CHECKIN}    ${checkout}=${DEFAULT_CHECKOUT}
    ...           ${additionalneeds}=${DEFAULT_NEEDS}
    
    ${bookingdates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${booking_data}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=${additionalneeds}
    
    RETURN    ${booking_data}

Validate Booking Response
    [Arguments]    ${response}    ${expected_data}
    Should Be Equal As Strings    ${response['firstname']}    ${expected_data['firstname']}
    Should Be Equal As Strings    ${response['lastname']}    ${expected_data['lastname']}
    Should Be Equal As Integers   ${response['totalprice']}    ${expected_data['totalprice']}
    Should Be Equal               ${response['depositpaid']}    ${expected_data['depositpaid']}
    Should Be Equal As Strings    ${response['bookingdates']['checkin']}    ${expected_data['bookingdates']['checkin']}
    Should Be Equal As Strings    ${response['bookingdates']['checkout']}    ${expected_data['bookingdates']['checkout']}
    Should Be Equal As Strings    ${response['additionalneeds']}    ${expected_data['additionalneeds']}

Get First Booking ID
    Setup API Session
    ${response}=    GET On Session    api    /booking
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ${bookings}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${bookings}
    ${first_booking}=    Get From List    ${bookings}    0
    ${booking_id}=    Get From Dictionary    ${first_booking}    bookingid
    RETURN    ${booking_id}