*** Settings ***
Resource    ../../resources/common/app.robot
Resource    ../../resources/procedures/interactions.robot
Resource    ../../resources/pages/controls_page.robot
Resource    ../../resources/pages/main_page.robot
Resource    ../../resources/pages/views_page.robot
 
Suite Setup    Open Installed App
Suite Teardown    Close App

*** Test Cases ***
Fill Form And Toggle On Dark Theme
    Goto Views
    Open Controls Dark Theme
    Fill Controls Form    Dark Mode Hello
    Checkbox Should Be Selected    Checkbox 1
    Radio Button Should Be Selected    RadioButton 1
    Text In First Field Should Be    Dark Mode Hello
