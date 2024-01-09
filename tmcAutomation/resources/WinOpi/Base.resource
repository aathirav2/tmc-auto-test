*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/config_credentials.resource
Library    FlaUILibrary
 

*** Keywords ***
Start WinOpi
    FlaUILibrary.Launch Application    ${winOpi}  
    Wait Until Element Exist    /Window/Window[@Name="Logon to TankMaster"]

Login to WinOpi
    ${Logon}=    Run Keyword And Return Status    Element Should Exist    /Window/Window[@Name="Logon to TankMaster"]
    IF    ${Logon}
        Set Text To Textbox    /Window/Window/Pane/Edit[1]    ${username_admin}
        Set Text To Textbox    /Window/Window/Pane/Edit[2]    ${password_admin} 
        Click    /Window/Window/Pane/Button[@Name="OK"] 
    ELSE
        Click    /Window/ToolBar/Button[@Name="Log on"]
        Set Text To Textbox    /Window/Window/Pane/Edit[1]    ${username_admin}
        Set Text To Textbox    /Window/Window/Pane/Edit[2]    ${password_admin} 
        Click    /Window/Window/Pane/Button[@Name="OK"] 
    END

Accept the alarms
    Click    /Window/ToolBar/Button[@Name="Alarm Summary for the Current Alarm Group"]
    Wait Until Element Exist    /Window/Pane[1]/Window[@Name="Alarm Summary - Group "All Tanks""]
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Accept All Alarms"]
    Wait Until Element Exist    /Window/Window[@Name="StmOpi"]
    Click    /Window/Window/Button[@Name="Yes"]
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    
Close WinOpi
    Click    /Window/TitleBar/Button[@Name="Close"]

    