*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/pages/main_page.robot
 
Suite Setup    Open App
Suite Teardown    Close App

*** Test Cases ***
Open Buttons Screen
    Goto Views
    Sleep    1s
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Animation"]    10
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Buttons"]    8
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="Buttons"]
    Wait Until Page Contains Element    xpath=//android.widget.Button[@text="NORMAL"]    5
    Go Back
    Go Back

Open Chronometer Screen
    Goto Views
    Sleep    1s
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Animation"]    10
    Wait Until Keyword Succeeds    3x    2s    Click Element    android=new UiScrollable(new UiSelector().className("android.widget.ListView")).scrollTextIntoView("Chronometer")
    Wait Until Page Contains Element    xpath=//android.widget.Button[@text="START"]    8
    Go Back
    Go Back

Open Seek Bar Screen
    Goto Views
    Sleep    1s
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Animation"]    10
    Scroll To Text    Seek Bar
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="Seek Bar"]
    Wait Until Page Contains Element    xpath=//android.widget.SeekBar    8
    Go Back
    Go Back
