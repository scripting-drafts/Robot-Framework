*** Settings ***
Resource    ../common/app.robot
Library     AppiumLibrary

*** Keywords ***
Toggle Checkbox
    [Arguments]    ${label}
    Wait Until Element Is Visible    xpath=//android.widget.CheckBox[@text="${label}"]    5
    Click Element    xpath=//android.widget.CheckBox[@text="${label}"]

Select Radio Button
    [Arguments]    ${label}
    Wait Until Element Is Visible    xpath=//android.widget.RadioButton[@text="${label}"]    5
    Click Element    xpath=//android.widget.RadioButton[@text="${label}"]

Enter Text In First Field
    [Arguments]    ${text}
    Wait Until Element Is Visible    xpath=(//android.widget.EditText)[1]    5
    Click Element    xpath=(//android.widget.EditText)[1]
    Clear Text    xpath=(//android.widget.EditText)[1]
    Input Text     xpath=(//android.widget.EditText)[1]    ${text}

Text In First Field Should Be
    [Arguments]    ${expected}
    ${value}=    Get Text    xpath=(//android.widget.EditText)[1]
    Should Be Equal    ${value}    ${expected}
