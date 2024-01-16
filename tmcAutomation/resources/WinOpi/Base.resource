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
    #Alarm Summary - Group "All Tanks"
    Wait Until Element Exist    /Window/Pane[1]/Window
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Accept All Alarms"]
    Wait Until Element Exist    /Window/Window[@Name="StmOpi"]
    Click    /Window/Window/Button[@Name="Yes"]
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Open all predefined tank views
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="TK-01"]
    Click  /Menu/MenuItem[@Name="View Tank"]    2000
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank View - Tank "TK-01"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console  Tank view is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="TK-01"]
    Click  /Menu/MenuItem[@Name="View Tank"]    2000
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank View Extended - Tank "TK-01"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console     Tank view extended is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="TK-01"]
    Click  /Menu/MenuItem[@Name="View Tank"]    2000
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank Inventory - Tank "TK-01"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console     Tank Inventory is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Create new tank view as copy of predefined view
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    
Close WinOpi
    Click    /Window/TitleBar/Button[@Name="Close"]

    