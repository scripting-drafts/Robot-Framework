*** Settings ***
Resource    ../common/app.robot
Library     AppiumLibrary

*** Keywords ***
Tap Menu Item
    [Arguments]    ${text}
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="${text}"]    10
    Click Element    xpath=//android.widget.TextView[@text="${text}"]

Goto Views
    Tap Menu Item    Views

Goto Preference
    Tap Menu Item    Preference
