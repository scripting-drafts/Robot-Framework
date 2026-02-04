*** Settings ***
Resource    ../common/app.robot
 

*** Keywords ***
Tap Menu Item
    [Arguments]    ${text}
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="${text}"]    10
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="${text}"]

Goto Views
    Ensure On Home Menu
    Tap Menu Item    Views

Goto Preference
    Ensure On Home Menu
    Tap Menu Item    Preference

Scroll To Text
    [Arguments]    ${text}
    # Swipe by percentage to avoid needing window size keyword
    FOR    ${i}    IN RANGE    0    6
        ${visible}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="${text}"]
        Exit For Loop If    ${visible}
        Swipe By Percent    50    80    50    30    800 ms
    END
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "${text}")]    8

Ensure On Home Menu
    Recover If Proxy Error
    # Ensure we're at the top-level API Demos home menu
    FOR    ${i}    IN RANGE    0    10
        ${a}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Accessibility"]
        ${v}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Views"]
        ${p}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Preference"]
        ${app}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="App"]
        ${ready}=    Evaluate    ${a} or ${v} or ${p} or ${app}
        Exit For Loop If    ${ready}
        Go Back
        Sleep    0.5s
    END
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Views"]    15
