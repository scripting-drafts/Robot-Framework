*** Settings ***
Resource    ../pages/controls_page.robot

*** Keywords ***
Fill Controls Form
    [Arguments]    ${text}
    Enter Text In First Field    ${text}
    Toggle Checkbox    Checkbox 1
    Toggle Checkbox    Checkbox 2
    Select Radio Button    RadioButton 1
