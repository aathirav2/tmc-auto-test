*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/config_credentials.resource
Library    FlaUILibrary


*** Keywords ***
Start WinSetup
    FlaUILibrary.Launch Application    ${winSetup} 
    #Loading time for application
    Sleep    10
    Wait Until Element Exist    /Window/Window[@Name="Logon to TankMaster"]

Login to WinSetup
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
    ${Result} =    Run Keyword And Return Status    Name Contains Text    Maximize    /Window/TitleBar/Button[2]  
    IF    ${Result} == True
        Click    /Window/TitleBar/Button[@Name="Maximize"]
    ELSE
        Log   Window is already maximised
    END

Expand Tree structure
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem[@Name="Network Connections"]
    ${Result}=    Run Keyword And Return Status   Name Contains Text    Expand All    /Menu/MenuItem[@Name="Expand All"]
    IF    ${Result} == True
        Click    /Menu/MenuItem[@Name="Expand All"]
    ELSE
        Click    /Menu/MenuItem[@Name="Collapse All"]
        Right Click    /Window/Pane[2]/Pane/Tree/TreeItem[@Name="Network Connections"]
        Click    /Menu/MenuItem[@Name="Expand All"]
    END

Close Winsetup
    Click    /Window/TitleBar/Button[@Name="Close"]