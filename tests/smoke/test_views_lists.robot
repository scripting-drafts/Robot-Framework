*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/pages/main_page.robot
 
Suite Setup    Open Installed App
Suite Teardown    Close App

*** Test Cases ***
Open Lists Screen
    Goto Views
    Sleep    1s
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Animation"]    10
    # Bring 'Lists' into view via swipe scroll and click
    Scroll To Text    Lists
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="Lists"]
    Sleep    1s

Open Simple List 1 Screen
    Goto Views
    Sleep    1s
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Animation"]    10
    Scroll To Text    Lists
    Wait Until Keyword Succeeds    3x    2s    Click Element    xpath=//android.widget.TextView[@text="Lists"]
    Sleep    1s
    # Open a stable list demo item: '10. Single choice list'
    Wait Until Keyword Succeeds    3x    2s    Click Element    android=new UiScrollable(new UiSelector().className("android.widget.ListView")).scrollTextIntoView("10. Single choice list")
    # Verify single-choice list entries are present (CheckedTextView items)
    Wait Until Page Contains Element    xpath=//android.widget.CheckedTextView    10
    Sleep    1s
    Go Back
    Sleep    1s
    Go Back
    Run Keyword And Ignore Error    Dump Current Page Source
