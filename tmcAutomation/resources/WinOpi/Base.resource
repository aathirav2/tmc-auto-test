*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/config_credentials.resource
Library    FlaUILibrary
 

*** Keywords ***
Start WinOpi
    FlaUILibrary.Launch Application    ${winOpi}  
    #Loading time for application
    Sleep    10 
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

Expand Tree structure
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[@Name="Groups"]
    ${Result}=    Run Keyword And Return Status   Name Contains Text    Expand All    /Menu/MenuItem[@Name="Expand All"]
    IF    ${Result} == True
        Click    /Menu/MenuItem[@Name="Expand All"]
    ELSE
        Click    /Menu/MenuItem[@Name="Collapse All"]
        Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[@Name="Groups"]
        Click    /Menu/MenuItem[@Name="Expand All"]
    END

Accept the alarms
    Click    /Window/ToolBar/Button[@Name="Alarm Summary for the Current Alarm Group"]
    #Alarm Summary - Group "All Tanks"
    Wait Until Element Exist    /Window/Pane[1]/Window
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Accept All Alarms"]
    Wait Until Element Exist    /Window/Window[@Name="StmOpi"]
    Click    /Window/Window/Button[@Name="Yes"]
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Open Tank view
    Sleep    4
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="${TK.Tag}"]
    Click  /Menu/MenuItem[@Name="View Tank"]    2000

Open all predefined tank views
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank View - Tank "${TK.Tag}"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console  Tank view is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank View Extended - Tank "${TK.Tag}"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console     Tank view extended is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank Inventory - Tank "${TK.Tag}"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console     Tank Inventory is opened
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Create new tank view as copy of predefined view
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    #Tank View - Tank "TK-01"
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window
    IF    ${Window}==True
        Log To Console     New tank view as copy of predefined tank view is created
    END
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Create new tank view as copy of predefined view with modifications
    Open Tank view
    Press Key    s'UP'
    Press Key    s'UP'
    Press Key    s'UP'
    Press Key    s'ENTER'
    #Tank View - Tank "TK-01"
    Wait Until Element Exist    /Window/Pane[1]/Window
    Press Key    s'CTRL+E' 
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Help"]
    Press Key    s'DELETE'
    Press Key    s'CTRL+F4'

#Create new tank view from scratch
    Open Tank view
    Press Key    s'UP'
    Press Key    s'UP'
    Press Key    s'ENTER'
    #Unnamed Custom View - Tank "${TK.Tag}"
    Click    /Window/Pane[1]/Window/Pane
    Press Key    s'CTRL+E'
    Click    /Window/Pane[1]/Window/Pane/Document
    #Enter the tank level
    Set Text To Textbox    /Window/Pane[1]/Window/Pane/Document    2.9
    #Focus    /Window/Window/ToolBar[@Name="Object Bar"]
    #Focus    /Window/Window/ToolBar/Button[@Name="CommandButton"]
    #Drag And Drop    /Window/Window/ToolBar/Button[@Name="CommandButton"]    /Window/Pane[1]/Window/Pane
    #Click    /Window/Pane[1]/Window/Pane/Button[@Name="CmdButton1"]
    #Clear Blacklist
    #Clear Whitelist
    #Set Text To Textbox    /Window/Pane[1]/Window/Pane/Button[@Name="CmdButton1"]    Close
    Press Key    s'CTRL+F4'

Set default double-click action for tank
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox[1]
    Expand Combobox    /Window/Window/Pane/ComboBox[1]
    Click    /Window/Window/Pane/ComboBox[1]/List/ListItem[1][@Name="Tank &View"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]
    Double Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="${TK.Tag}"]
    Wait Until Element Exist    /Window/Pane[1]/Window
    ${Window}    Get Name From Element    /Window/Pane[1]/Window
    Should Contain    ${Window}   Tank View - Tank "${TK.Tag}"
    #Should Contain    ${Window}   Tank View Extended - Tank "${TK.Tag}"
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

    
Close WinOpi
    Click    /Window/TitleBar/Button[@Name="Close"]

    