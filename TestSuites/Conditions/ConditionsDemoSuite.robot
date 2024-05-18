

*** Test Cases ***

Condition explanation tc
        # >
        ${age}  Set Variable    18
        Log    ${age}
        ${result}   Evaluate    ${age}>17
        Log    ${result}


        ${result}   Evaluate    ${age}>=18
        Log    ${result}

        ${result}   Evaluate    ${age}<101
        Log    ${result}

         ${result}   Evaluate    ${age}<=100
        Log    ${result}

        ${age}  Set Variable    17
        ${result}   Evaluate    ${age}==18
        Log    ${result}

         ${result}   Evaluate    ${age}!=18
        Log    ${result}

        ${person}  Set Variable    Varsha
        ${result}   Evaluate    "${person}"=="varsha"
        Log    ${result}

         # CASE SENSITIVE SIMILAR
        ${person}  Set Variable    Varsha
        ${result}   Evaluate    "${person}".lower()=="varsha".lower()
        Log    ${result}

        ${person}  Set Variable    Varsha
        ${result}   Evaluate    "${person}"!="Varsha"
        Log    ${result}

String partial match

        # PARTTIAL MATCH
        ${person}  Set Variable    Varsha Narwaria
        ${result}   Evaluate    "Varsha" in "${person}"
        Log    ${result}
        
        
Check And or not matching

        ${person}  Set Variable    Varsha Narwaria
        ${age}  Set Variable    18
        ${ward}     Set Variable    1
        
        ${result1}   Evaluate    "Varsha" in "${person}"
        Log    ${result1}
        
        ${result2}   Evaluate    ${age}>=18
        Log    ${result2}

         ${result3}   Evaluate    ${ward} == 1
        Log    ${result3}
        
        ${finalResult}  Evaluate    ${result1} and ${result2} and {$result3}
        Log    ${finalResult}


Practice for If Else and Else If constructs
            IF      ${True}
                  log    1
            END
            log    2

            IF      ${False}
                  log    3
            END
            log    4


            IF      ${True}
                Log     5
            ELSE
                log     6
            END

            # LADDER
            IF      ${True}
                Log     7
            ELSE IF     ${False}
                log     8
            ELSE
                log    9
            END

            # NESTED IF

            IF      ${True}
                log     10
                IF      ${True}
                     Log     11
                ELSE IF     ${False}
                      log     12
                ELSE
                      log  13
                END
                 log       14
            END


Final use of all conditional statements to decide a user can vote or not
        ${person}       Set Variable    Varsha
        ${age}      Set Variable    17
        ${ward}     Set Variable    1
        ${alreadyVoted}     Set Variable    ${False}

        IF      ${age} >= 18 and ${ward} == 1 and not(${alreadyVoted}) and "Varsha" == "${person}"
                log    You can Vote!
        ELSE
                log    You can not Vote!
        END


Run keyword if and unless example

        ${person}       Set Variable    Varsha
        ${age}      Set Variable    18
        ${ward}     Set Variable    1
        ${alreadyVoted}     Set Variable    ${False}

        Run Keyword If      ${age} >= 18 and ${ward} == 1 and not(${alreadyVoted}) and "Varsha" == "${person}"      Start voting process

        Run Keyword Unless      ${age} >= 18 and ${ward} == 1 and not(${alreadyVoted}) and "Varsha" == "${person}"      Not allow to vote

*** Keywords ***

Start voting process
        log many        "Generate Receipt"
        ...             "Apply Finger marking"
        ...             "Register Vote"
        ...             "Go Home"

Not allow to vote
        log many    "Go Home"
        ...         "File a Report, internal database"
