*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/pages/main_page.robot
 
Suite Setup    Open Installed App
Test Setup     Ensure On Home Menu
Suite Teardown    Close App

*** Test Cases ***
Open Accessibility Menu
    Tap Menu Item    Accessibility
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Accessibility")]
    Go Back

Open Animation Menu
    Tap Menu Item    Animation
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Animation")]
    Go Back

Open App Menu
    Tap Menu Item    App
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Activity")]
    Go Back

Open Content Menu
    Tap Menu Item    Content
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Resources")]
    Go Back

Open Graphics Menu
    Tap Menu Item    Graphics
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "AlphaBitmap")]
    Go Back

Open Media Menu
    Tap Menu Item    Media
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Audio")]
    Go Back


Open Preference Menu
    Goto Preference
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Preference")]
    Go Back

Open Text Menu
    Tap Menu Item    Text
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="LogTextBox"]
    Go Back

Open Views Menu
    Goto Views
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Buttons")]
    Go Back

*** Keywords ***
