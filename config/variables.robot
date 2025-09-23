*** Variables ***
# API Configuration
${BASE_URL}              https://restful-booker.herokuapp.com
${API_TIMEOUT}           30

# Authentication
${ADMIN_USERNAME}        admin
${ADMIN_PASSWORD}        password123

# Test Data
${DEFAULT_FIRSTNAME}     John
${DEFAULT_LASTNAME}      Doe
${DEFAULT_TOTALPRICE}    100
${DEFAULT_DEPOSITPAID}   ${True}
${DEFAULT_CHECKIN}       2024-01-01
${DEFAULT_CHECKOUT}      2024-01-02
${DEFAULT_NEEDS}         Breakfast

# HTTP Status Codes
${STATUS_OK}             200
${STATUS_CREATED}        201
${STATUS_NO_CONTENT}     204
${STATUS_BAD_REQUEST}    400
${STATUS_UNAUTHORIZED}   401
${STATUS_FORBIDDEN}      403
${STATUS_NOT_FOUND}      404
${STATUS_METHOD_NOT_ALLOWED}    405

# Headers
&{JSON_HEADERS}          Content-Type=application/json    Accept=application/json