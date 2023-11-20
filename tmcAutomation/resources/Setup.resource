*** Settings ***
Documentation    Common functions across all applications: WinAppDriver, WinSetup, WinOpi and System administrator
Library    ApplicationLibrary.DesktopLibrary
Library    OperatingSystem
Resource    ../resources/config.resource


*** Keywords ***
Start App
    [Documentation]    Sets up the application for quick launching through 'Launch Application' and starts the winappdriver
    ...    Note that the winappdriver must be launched before the test eithe manually or through a script on the target machine
    #Driver Setup    
    Open Application    ${REMOTE_URL}    platformName=Windows    deviceName=Windows    app=${Notepad}    alias=Main
    Maximize Window
    Quit Application


Close App
    Close Application
    
    
    