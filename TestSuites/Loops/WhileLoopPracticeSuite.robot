


*** Test Cases ***

WHILE: A simple while loop
        log    Starting the while loop

        WHILE    False
            log    Executed until the default loop limit (10000) is hit.
        END

        WHILE    True
            log    Executed until the default loop limit (10000) is hit.
        END


WHILE: A simple while loop using the default loop limit
        WHILE    True       limit=10
            log    Executed until the default loop limit (10) is hit.
        END

WHILE: Loop while the default loop limit (10) is hit
    TRY
        WHILE    True       limit=10
            log    Executed until the default loop limit (10) is hit.
        END
    EXCEPT    WHILE loop was aborted    type=start
        log    The loop didn't finish within the limit
    END

WHILE: Loop while evaluates to True or the default loop limit is hit
    ${x}=   set variable    ${0}
    WHILE    ${x} < 3
            log    Executed as long as the condition is true
            ${x}=   Evaluate    ${x} +1
        END
