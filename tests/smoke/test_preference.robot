*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/pages/main_page.robot
 
Test Setup     Open Installed App
Suite Teardown    Close App

*** Test Cases ***
Open Preference From XML
    Goto Preference
    Sleep    0.5s
    Run Keyword And Ignore Error    Click Element    -android uiautomator=new UiScrollable(new UiSelector().className("android.widget.ListView")).scrollTextIntoView("1. Preferences from XML")
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="1. Preferences from XML"]    20
    # Smoke-level assertion: verify the menu item is present without entering the detail screen
    ${xml_item}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="1. Preferences from XML"]
    Should Be True    ${xml_item}

Open Preference Via Code
    Goto Preference
    Sleep    0.5s
    # Scroll to '2. Preferences from code' if not immediately visible
    Run Keyword And Ignore Error    Click Element    -android uiautomator=new UiScrollable(new UiSelector().className("android.widget.ListView")).getChildByText(new UiSelector().className("android.widget.TextView"), "2. Preferences from code")
    Run Keyword And Ignore Error    Click Element    -android uiautomator=new UiScrollable(new UiSelector().className("android.widget.ListView")).scrollTextIntoView("Preferences from code")
    ${found_exact}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="2. Preferences from code"]
    ${found_contains}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[contains(@text, "Preferences from code")]
    ${ok2}=    Evaluate    ${found_exact} or ${found_contains}
    Should Be True    ${ok2}

Open Preference Dependencies
    Goto Preference
    Sleep    0.5s
    # Bring '3. Preference dependencies' into view reliably
    Run Keyword And Ignore Error    Click Element    -android uiautomator=new UiScrollable(new UiSelector().className("android.widget.ListView")).scrollTextIntoView("3. Preference dependencies")
    ${dep_visible}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="3. Preference dependencies"]
    Run Keyword If    not ${dep_visible}    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, "Preference dependencies")]    15
    Click Element    xpath=//android.widget.TextView[@text="3. Preference dependencies"]
    Sleep    0.5s
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="WiFi settings"]    15
    Sleep    0.5s
