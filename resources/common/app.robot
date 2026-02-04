*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}       http://127.0.0.1:4723
${PLATFORM_NAME}    Android
${AUTOMATION_NAME}  UiAutomator2
${DEVICE_NAME}      Android Emulator
${APP_PATH}         ${CURDIR}/../../apps/ApiDemos-debug.apk
${APP_PACKAGE}      io.appium.android.apis
${APP_ACTIVITY}     .ApiDemos

*** Keywords ***
Open App
    [Documentation]    Opens the ApiDemos app using default capabilities
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    app=${APP_PATH}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    newCommandTimeout=180
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Accessibility"]    10

Close App
    [Documentation]    Closes the current Appium session
    Close Application

Open Installed App
    [Documentation]    Opens the app via package/activity when already installed on device
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    newCommandTimeout=180
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Accessibility"]    10
