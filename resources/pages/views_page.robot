*** Settings ***
Resource    ../common/app.robot
 

*** Keywords ***
Open Controls
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Controls"]    10
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="Controls"]

Open Controls Light Theme
    Open Controls
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="1. Light Theme"]    10
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="1. Light Theme"]

Open Controls Dark Theme
    Open Controls
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="2. Dark Theme"]    10
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="2. Dark Theme"]
