*** Settings ***
Resource    ../keywords/create_booking_keywords.robot
Library          RequestsLibrary
Library           BuiltIn
Library           Collections

*** Test Cases ***
Criar Reserva Simples
    ${payload}=    Create Dictionary
    ...    firstname=Jim
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=${True}
    ...    bookingdates=${EMPTY}
    ...    additionalneeds=Breakfast
    ${bookingdates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${payload}    bookingdates    ${bookingdates}
    ${booking}=    Criar Reserva    ${payload}
    Log    Reserva criada: ${booking}
    Should Contain    ${booking}    bookingid
    Should Contain    ${booking['booking']}    firstname
    Should Be Equal As Strings    ${booking['booking']['firstname']}    Jim

