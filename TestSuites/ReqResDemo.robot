*** Settings ***
Library     RequestsLibrary

*** Variables ***
${BASE_URL}     https://reqres.in

*** Test Cases ***

Get User List
        #   https://reqres.in/api/users?page=2
        GET     https://reqres.in/api/users     params=page=2

Get user list and verify data
            ${responseObj}      GET     ${BASE_URL}/api/users     params=page=2       expected_status=200
            ${jsonVar}      Set Variable  ${responseObj.json()}
            Log     ${jsonVar['data'][0]['first_name']}
            Should Be Equal As Strings    ${jsonVar['data'][0]['first_name']}    Michael

Get single user and verify data
         ${responseObj}      GET     ${BASE_URL}/api/users/2
        Status Should be       200
        ${jsonVar}      Set Variable  ${responseObj.json()}
        Should Be Equal As Strings    ${jsonVar['data']['first_name']}    Janet

Create a new user
        ${payload}       Create Dictionary   name=morpheus  job=leader
        ${responseObj}      POST     ${BASE_URL}/api/users      json=${payload}
        Status Should Be    201
        ${jsonVar}      Set Variable  ${responseObj.json()}
        Should Be Equal As Strings    ${jsonVar['name']}    morpheus

Login with valid user
        ${payload}       Create Dictionary   email=eve.holt@reqres.in  password=cityslicka
        ${responseObj}      POST     ${BASE_URL}/api/login      json=${payload}
        Status Should Be    200
        ${jsonVar}      Set Variable  ${responseObj.json()}
        Should Not Be Empty     ${jsonVar['token']}
        ${token}        Set Variable    ${jsonVar['token']}
        Log     ${token}

Update user details
        ${payload}       Create Dictionary   name=morpheus  job=zion resident
        ${responseObj}      PUT     ${BASE_URL}/api/users/2      json=${payload}    expected_status=200
        ${jsonVar}      Set Variable  ${responseObj.json()}
        Should Not Be Empty     ${jsonVar['updatedAt']}

Delete user details
        ${responseObj}      DELETE     ${BASE_URL}/api/users/2    expected_status=204




