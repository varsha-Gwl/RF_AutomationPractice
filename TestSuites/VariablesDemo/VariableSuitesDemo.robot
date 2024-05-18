*** Settings ***
Library    String
Resource    VariablesCommon.robot

*** Variables ***
${BASE_URL}     https://mybaseurl.com
# to create list global use @, $ won't work
@{GLOBAL_LIST}      Red     blue    Green
&{GLOBAL_DICT}    email=varsha34@gmail.com  pwd=Test546
${ENV}  DEV

*** Keywords ***
My Keyword
        ${v1}   Set Variable    Hello
        Log    ${v1}

*** Test Cases ***

Precedence and Scope
        Log    ${ENV}
        ${ENV}  Set Variable    PROD
        Log    ${ENV}

Builtin/Runtime Variable Demo
        Log    ${ENV}$ {BROWSER}
        Log    ${CURDIR} 
        Log    ${LOG_FILE}

Date manipulation
    ${v1}   Evaluate    datetime.date.today()
    Log    ${v1}
    ${v2}   Evaluate    datetime.date.today()+datetime.timedelta(7)
     Log    ${v2}
      ${v3}   Evaluate    datetime.date.today()+datetime.timedelta(-7)
     Log    ${v3}

        # inline evaluation
        ${inline_eval}    Set Variable      ${{datetime.date.today()+datetime.timedelta(-7)}}
        Log    ${inline_eval}


Type conversion from Strings to number
        ${v1}   Set Variable    '5.512'
        ${v1}   Replace String    ${v1}    '    ${EMPTY}
        ${v2}   Convert To Number    ${v1}
        ${v3}   Evaluate    ${v2}+10
        Log    ${v3}

Generate Random Number Demo
        ${email_part1}      Set Variable    varsha
        ${email_part2}      Set Variable    @gmail.com
        ${random_number}    Generate Random String      4   [NUMBERS]
        Log     ${random_number}
        ${final_email}      Set Variable    ${email_part1}${random_number}${email_part2}
        Log    ${final_email}

Dictionary Variable - Demo
    # KEY : VALUE
    # KEY is always String, can't be null, blank
    # VALUE can be numeric, String, Boolean, List, Dictonary, Object

    ${dict_name}    Create Dictionary   email=varsha@gmail.com  pwd=pwd245
    Log    ${dict_name}
    &{dict_name}    Create Dictionary   Content-Type=text/json  Authorization=Bearer token value
    Log    ${dict_name}

     Log    ${GLOBAL_DICT}
     Log    ${GLOBAL_DICT.pwd}


List Variable - Demo
        # list should be homogenous
        ${list_name}    Create List     1   2   3   4   5
        Log    ${list_name}
        @{list_name}    Create List     Apple   Kiwi    Berry
        Log    ${list_name}
        # Doesn't work
        #Log    @{list_name}

        Log    ${GLOBAL_LIST}
        Log    ${GLOBAL_LIST[0]}

Scalar Variable - Type Demo
        ${var}      Set Variable    Hello World
        Log     ${var}

        ${var}      Set Variable    ${var}${SPACE}Varsha
        ${var}      Set Variable    1
        Log     ${var}
         ${var}      Set Variable   1.2
        Log     ${var}
        ${var}      Set Variable   ${True}
        Log     ${var}
        ${var}      Set Variable   ${False}
        Log     ${var}
        
        Log    ${BASE_URL}
         ${var}      Set Variable   ${None}
         Log     ${var}
         ${var}      Set Variable   ${null}
         Log     ${var}
         ${var}      Set Variable   ${SPACE}
         Log     ${var}
         ${var}      Set Variable   ${EMPTY}
         Log     ${var}
         
         Log    %{PATH}

Scalar Variable - Calculation Demo
        ${v1}       Set Variable    5
        ${v2}       Set Variable    3
        ${result}   Evaluate    ${v1}+${v2}
        Log    ${result}
         ${result}   Evaluate    ${v1}-${v2}
        Log    ${result}
         ${result}   Evaluate    ${v1}*${v2}
        Log    ${result}
         ${result}   Evaluate    ${v1}/${v2}
        Log    ${result}
         ${result}   Evaluate    ${v1}%${v2}
        Log    ${result}
        
        ${r}    Set Variable        5
        ${pie}  Set Variable        3.14
        ${area}     Evaluate    ${pie}*${r}*${r}

