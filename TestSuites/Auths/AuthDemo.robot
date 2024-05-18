*** Settings ***
Library     RequestsLibrary
Library    Base64Converter.py

*** Test Cases ***

HTTP auth demo - Basic Auth
    ${BASE_URL}     Set Variable    https://httpbin.org
    ${USERNAME}     Set Variable    path
    ${PASSWORD}     Set Variable    path
    ${BASE64STR}    get base64 string    ${USERNAME}    ${PASSWORD}
    ${HEADERS}       create dictionary    accept=application/json        Authorization=Basic ${BASE64STR}
    ${response}     GET     ${BASE_URL}/basic-auth/${USERNAME}/${PASSWORD}      headers=${HEADERS}


HTTP auth demo - Digest Auth
    ${BASE_URL}     Set Variable    https://httpbin.org
    ${USERNAME}     Set Variable    path
    ${PASSWORD}     Set Variable    path
    ${HEADERS}       create dictionary    accept=application/json        Authorization=Digest username="path", realm="me@kennethreitz.com", nonce="e091352a0d7bc31f1661c223330c1531", uri="/digest-auth/auth/path/path", algorithm="MD5", qop=auth, nc=00000001, cnonce="zeAnmoi6", response="ac2b3f613b58451cea20be0b29fd6a2c", opaque="dadcde7e24105a9bae0cb6d0c3a4da7a"
    ${response}     GET     ${BASE_URL}/digest-auth/auth/${USERNAME}/${PASSWORD}      headers=${HEADERS}


Session Based Auth
    ${BASE_URL}     Set Variable    https://restful-booker.herokuapp.com
    ${PAYLOD_BODY}       create dictionary      username=admin      password=password123
    ${HEADERS}       create dictionary    Content-Type=application/json
    ${response}     POST     ${BASE_URL}/auth   json=${PAYLOD_BODY}     headers=${HEADERS}
    Status Should Be    200
    ${json_body}        Set Variable    ${response.json()}
    log    ${json_body}
   # log     ${json_body['token']}
    should not be empty    ${json_body['token']}