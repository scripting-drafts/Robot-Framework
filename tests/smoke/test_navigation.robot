*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/procedures/navigation.robot
Library     AppiumLibrary
Suite Setup    Open App
Suite Teardown    Close App

*** Test Cases ***
Open Controls Light Theme Screen
    Go To Controls Light Theme
    Wait Until Page Contains Element    xpath=//android.widget.CheckBox[@text="Checkbox 1"]    5
    Page Should Contain Element    xpath=(//android.widget.EditText)[1]
