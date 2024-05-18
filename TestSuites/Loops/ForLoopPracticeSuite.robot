

*** Variables ***
@{ROBOTS_lIST}      Bender  Johny5  Terminator  Robocop
@{LIST}      one two three
${STRING}       cat
${NUMBER}       ${1}
&{DICTIONARY}      string=${STRING}    number=${NUMBER}    list=@{LIST }

*** Test Cases ***
Loop over a list items and log each of them
    FOR    ${item}    IN    @{ROBOTS_lIST}
        Log    ${item}

    END

Loop over a list items and log each of them but STOP at Terminator
    FOR    ${item}    IN    @{ROBOTS_lIST}
        Log    ${item}
        IF    "${item}" == "Terminator"
            BREAK
        END
    END

Loop over a list items and log each of them but SKIP at Terminator
    FOR    ${item}    IN    @{ROBOTS_lIST}
        #Log    ${item}
        IF    "${item}" == "Terminator"
            CONTINUE
        END
        Log    ${item}
    END

Loop a List
    Log     ${LIST}         #{'one', 'two', 'three'}
    FOR    ${item}      IN    @{LIST}
        log    ${item}      # one, two, three
    END

     FOR    ${item}      IN     one     two     three
        log    ${item}
    END

Loop a Dictionary
    Log     ${DICTIONARY}

    FOR    ${key_value_tuple}      IN    &{DICTIONARY}
        log    ${key_value_tuple}      # one, two, three
    END

     FOR    ${key}      IN     @{DICTIONARY}
        #log     ${key}
       #log    ${key}=${DICTIONARY}[${key}]
       log    ${DICTIONARY}[${key}]
       log    ${DICTIONARY.${key}}
    END

Loop a range from 0 to end index
    FOR    ${index}     IN RANGE    10
        log    ${index}
    END

Loop a range from start to end index
    FOR    ${index}     IN RANGE    4   10
        log    ${index}
    END

Loop a range from start to end index with steps
    FOR    ${index}     IN RANGE    0   10  3
        log    ${index}
    END

Nested Loops
    @{alphabets}=       Create List    a    b   c
         log    ${alphabets}
     @{numbers}=       Create List    ${1}    ${2}   ${3}
        log    ${numbers}

    FOR    ${alphabet}     IN     @{alphabets}
        FOR    ${number}     IN     @{numbers}
        log    ${alphabet}${number}
        END
    END

Exit a loop on condition
    FOR    ${i}     IN RANGE    5
        IF  ${i} == 2   BREAK
        log    ${i}
    END

Continue a loop from the next iteration on condition
    FOR    ${i}     IN RANGE    3
        IF  ${i} == 1   CONTINUE
        log    ${i}
    END



