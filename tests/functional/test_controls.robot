*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/procedures/navigation.robot
Resource    ../../resources/procedures/interactions.robot
Resource    ../../resources/pages/controls_page.robot
Library     AppiumLibrary
Suite Setup    Open App
Suite Teardown    Close App

*** Test Cases ***
Fill Form And Toggle
    Go To Controls Light Theme
    Fill Controls Form    Hello Appium
    Element Should Be Selected    xpath=//android.widget.CheckBox[@text="Checkbox 1"]
    Element Should Be Selected    xpath=//android.widget.RadioButton[@text="RadioButton 1"]
    Text In First Field Should Be    Hello Appium
