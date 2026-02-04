*** Settings ***
Resource    ../common/app.robot
Library     AppiumLibrary

*** Keywords ***
Open Controls
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Controls"]    10
    Click Element    xpath=//android.widget.TextView[@text="Controls"]

Open Controls Light Theme
    Open Controls
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="1. Light Theme"]    10
    Click Element    xpath=//android.widget.TextView[@text="1. Light Theme"]
