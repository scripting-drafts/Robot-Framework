*** Settings ***
Library    AppiumLibrary    run_on_failure=Run On Failure Handler
Library    OperatingSystem
Library    DateTime

*** Variables ***
${REMOTE_URL}       http://127.0.0.1:4723
${PLATFORM_NAME}    Android
${AUTOMATION_NAME}  UiAutomator2
${DEVICE_NAME}      Android Emulator
${APP_PATH}         ${CURDIR}/../../apps/ApiDemos-debug.apk
${APP_PACKAGE}      io.appium.android.apis
${APP_ACTIVITY}     .ApiDemos
${UIA2_INSTALL_TIMEOUT}    180000
${ADB_EXEC_TIMEOUT}        180000
${UIA2_LAUNCH_TIMEOUT}     180000

*** Keywords ***
Open App
    [Documentation]    Opens the ApiDemos app; reads optional UDID from suite variable `${UDID}`
    ${udid}=    Get Variable Value    ${UDID}    ${EMPTY}
    Run Keyword If    '${udid}' == ''    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    app=${APP_PATH}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    appWaitActivity=${APP_ACTIVITY}    newCommandTimeout=180    uiautomator2ServerInstallTimeout=${UIA2_INSTALL_TIMEOUT}    uiautomator2ServerLaunchTimeout=${UIA2_LAUNCH_TIMEOUT}    adbExecTimeout=${ADB_EXEC_TIMEOUT}    ignoreUnimportantViews=true    disableWindowAnimation=true    clearSystemFiles=true    noReset=false
    Run Keyword If    '${udid}' != ''    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    app=${APP_PATH}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    appWaitActivity=${APP_ACTIVITY}    udid=${udid}    newCommandTimeout=180    uiautomator2ServerInstallTimeout=${UIA2_INSTALL_TIMEOUT}    uiautomator2ServerLaunchTimeout=${UIA2_LAUNCH_TIMEOUT}    adbExecTimeout=${ADB_EXEC_TIMEOUT}    ignoreUnimportantViews=true    disableWindowAnimation=true    clearSystemFiles=true    noReset=false
    Set Appium Timeout    20 seconds
    FOR    ${i}    IN RANGE    0    10
        ${a}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Accessibility"]
        ${v}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Views"]
        ${p}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Preference"]
        ${app}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="App"]
        ${ready}=    Evaluate    ${a} or ${v} or ${p} or ${app}
        Exit For Loop If    ${ready}
        Go Back
        Sleep    0.5s
    END
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Accessibility"]    20

Run On Failure Handler
    [Documentation]    Attempt to capture a screenshot on failure without raising additional errors
    [Arguments]    ${message}=
    ${_}=    Run Keyword And Ignore Error    Capture Page Screenshot
    ${_}=    Run Keyword And Ignore Error    Dump Current Page Source
    Log    Run-on-failure: ${message}    WARN

Dump Current Page Source
    [Documentation]    Save current page XML to reports for debugging selectors
    ${src}=    Get Source
    ${ts}=    Get Time    epoch
    ${file}=    Set Variable    ${CURDIR}/../../reports/page-source-${SUITE NAME}-${TEST NAME}-${ts}.xml
    Create File    ${file}    ${src}
    Log    Saved page source to ${file}    WARN

Recover If Proxy Error
    [Documentation]    If the Appium proxy is broken (e.g., socket hang up), restart the app/session
    ${ok}=    Run Keyword And Return Status    Get Source
    Run Keyword If    not ${ok}    Close Application
    Run Keyword If    not ${ok}    Sleep    1s
    Run Keyword If    not ${ok}    Open Installed App


Close App
    [Documentation]    Closes the current Appium session
    Close Application

Open Installed App
    [Documentation]    Opens the app via package/activity when already installed on device; reads UDID from suite variable `${UDID}`
    ${udid}=    Get Variable Value    ${UDID}    ${EMPTY}
    Run Keyword If    '${udid}' == ''    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    appWaitActivity=${APP_ACTIVITY}    newCommandTimeout=180    uiautomator2ServerInstallTimeout=${UIA2_INSTALL_TIMEOUT}    uiautomator2ServerLaunchTimeout=${UIA2_LAUNCH_TIMEOUT}    adbExecTimeout=${ADB_EXEC_TIMEOUT}    ignoreUnimportantViews=true    disableWindowAnimation=true    clearSystemFiles=true    noReset=false
    Run Keyword If    '${udid}' != ''    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    appWaitActivity=${APP_ACTIVITY}    udid=${udid}    newCommandTimeout=180    uiautomator2ServerInstallTimeout=${UIA2_INSTALL_TIMEOUT}    uiautomator2ServerLaunchTimeout=${UIA2_LAUNCH_TIMEOUT}    adbExecTimeout=${ADB_EXEC_TIMEOUT}    ignoreUnimportantViews=true    disableWindowAnimation=true    clearSystemFiles=true    noReset=false
    Set Appium Timeout    20 seconds
    FOR    ${i}    IN RANGE    0    10
        ${a}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Accessibility"]
        ${v}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Views"]
        ${p}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="Preference"]
        ${app}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="App"]
        ${ready}=    Evaluate    ${a} or ${v} or ${p} or ${app}
        Exit For Loop If    ${ready}
        Go Back
        Sleep    0.5s
    END
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Accessibility"]    20
