*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/pages/main_page.robot
Resource    ../../resources/pages/views_page.robot
 
Suite Setup    Open Installed App
Suite Teardown    Close App

*** Test Cases ***
Open Controls Dark Theme Screen
    Goto Views
    Open Controls Dark Theme
    Wait Until Page Contains Element    xpath=//android.widget.CheckBox[@text="Checkbox 1"]    5
