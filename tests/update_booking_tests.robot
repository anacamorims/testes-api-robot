*** Settings ***
Resource    ../keywords/update_booking_keyords.robot

*** Test Cases ***
Testar PUT Booking Completo
    Create Session    api    ${BASE_URL}
    ${token}=    Obter_Token
    ${booking_id}=    Obter Primeira Reserva pelo Id
    ${payload}=    Create Dictionary
    ...    firstname=James
    ...    lastname=Brown
    ...    totalprice=111
    ...    depositpaid=${True}
    ...    bookingdates=${EMPTY}
    ...    additionalneeds=Breakfast

    ${bookingdates}=    Create Dictionary    checkin=2018-01-01    checkout=2019-01-01
    Set To Dictionary    ${payload}    bookingdates    ${bookingdates}
    ${booking}=    Atualizar Reserva Completa    ${booking_id}    ${payload}    ${token}

    Log    Booking atualizado: ${booking}
    Should Be Equal As Strings    ${booking['firstname']}    James
    Should Be Equal As Strings    ${booking['lastname']}     Brown
    Should Be Equal As Integers   ${booking['totalprice']}  111
    Should Be True                ${booking['depositpaid']}
    Should Be Equal As Strings    ${booking['bookingdates']['checkin']}     2018-01-01
    Should Be Equal As Strings    ${booking['bookingdates']['checkout']}    2019-01-01
    Should Be Equal As Strings    ${booking['additionalneeds']}                Breakfast