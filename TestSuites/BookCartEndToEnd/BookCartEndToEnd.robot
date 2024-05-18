*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary

*** Variables ***
${BASE_URL}     https://bookcart.azurewebsites.net

*** Test Cases ***
Get all books
        ${response}     GET     ${BASE_URL}/api/Book
        ${json}     Set Variable    ${response.json()}
        log    {json}
        ${booktitle}    set variable    ${json[0]['title']}
        log    ${booktitle}
        should be equal as strings    ${booktitle}      Harry Potter and the Chamber of Secrets
        validate json by schema file        ${json}    ${CURDIR}/allBooksSchema.json


Add a book to the Wishlist
        ${bookId}       set variable    3
         #Login
        ${headers}      create dictionary    Content-Type=application/json
        ${payload}      load json from file     ${CURDIR}/login.json
        ${response}     POST     ${BASE_URL}/api/Login      json=${payload}     headers=${headers}      expected_status=200
        ${json}     set variable        ${response.json()}
        ${token}    set variable    ${json['token']}
        ${userId}    set variable    ${json['userDetails']['userId']}

        # Delete the wishlist completely
        ${headers}      create dictionary    accept=text/plain      Authorization=bearer ${token}
        ${response}     DELETE    ${BASE_URL}/api/Wishlist/${userId}        headers=${headers}      expected_status=200

        #Toggle wishlist
        ${headers}      create dictionary    accept=text/plain      Authorization=bearer ${token}
        ${response}     POST    ${BASE_URL}/api/Wishlist/ToggleWishlist/${userId}/${bookId}     headers=${headers}
        ${json}     set variable        ${response.json()}
        log    ${json}

        #Verify wishlist
         ${headers}      create dictionary    accept=text/plain
         ${response}    GET    ${BASE_URL}/api/Wishlist/${userId}       headers=${headers}
         ${json}     set variable        ${response.json()}
         should be equal as numbers    ${bookId}    ${json[0]['bookId']}


Add a book to the Cart
        ${bookId}       set variable    3

         #Login
        ${headers}      create dictionary    Content-Type=application/json
        ${payload}      load json from file     ${CURDIR}/login.json
        ${response}     POST     ${BASE_URL}/api/Login      json=${payload}     headers=${headers}      expected_status=200
        ${json}     set variable        ${response.json()}
        ${token}    set variable    ${json['token']}
        ${userId}    set variable    ${json['userDetails']['userId']}

        # Add to Cart
        ${headers}      create dictionary    accept=text/plain
         ${response}     POST    ${BASE_URL}/api/ShoppingCart/AddToCart/${userId}/${bookId}     headers=${headers}

