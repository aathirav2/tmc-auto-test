*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/config_credentials.resource
Library    FlaUILibrary      screenshot_dir=None  
Library    String

*** Variables *** 
${index}

*** Keywords ***
Start WinOpi
    FlaUILibrary.Launch Application    ${winOpi}  
    #Loading time for application
    Sleep    10

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
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem/TreeItem[@Name="${TK.Tag}"]
    Click  /Menu/MenuItem[@Name="View Tank"]    2000

Open all predefined tank views
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Tank View - Tank "${TK.Tag}"
    Log To Console  Tank view is opened
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Tank View Extended - Tank "${TK.Tag}"
    Log To Console     Tank view extended is opened
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Tank Inventory - Tank "${TK.Tag}"
    Log To Console     Tank Inventory is opened
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

#Create new tank view as copy of predefined view
    Open Tank view
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Tank View - Tank "${TK.Tag}"
    Log To Console     New tank view as copy of predefined tank view is created
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]

Make modification in custom view
    Open Tank view
    Press Key    s'UP'
    #Press Key    s'UP'
    #Press Key    s'UP'
    Press Key    s'ENTER'
    #Tank View - Tank "${TK.Tag}"
    Wait Until Element Exist    /Window/Pane[1]/Window
    Sleep    4
    Press Key    s'CTRL+E'
    ${Element}=    Run Keyword And Return Status    Element Should Exist    /Window/Pane[1]/Window/Pane/Button[@Name="Help"]
    IF    ${Element}==True
        Click    /Window/Pane[1]/Window/Pane/Button[@Name="Help"]
        Press Key    s'DELETE'
        Log To Console     Copy of Tank view is modified by deleting help command button
    ELSE
        Focus    /Window/Window/ToolBar[@Name="Object Bar"]
        Focus    /Window[2]/Window/ToolBar/Button[5][@Name="CommandButton"]
        Drag And Drop    /Window[2]/Window/ToolBar/Button[5][@Name="CommandButton"]       /Window/Pane[1]/Window/Pane
    END
    Press Key    s'CTRL+F4'
    #Open the view

Edit created custom view from scratch 
    Open Tank view
    Press Key    s'UP'
    #Press Key    s'UP'
    Press Key    s'ENTER'
    #Unnamed Custom View - Tank "${TK.Tag}"
    Click    /Window/Pane[1]/Window/Pane
    Press Key    s'CTRL+E'
    Right Click    /Window/Pane[1]/Window/Pane/Document
    Wait Until Element Exist    /Window/Window[@Name="Property Sheet"]
    Expand Combobox    /Window/Window[1]/ComboBox
    Click    /Window/Window[1]/ComboBox/List/ListItem[@Name="Label1"]

    #Enter the tank level
    #Set Text To Textbox    /Window/Pane[1]/Window/Pane/Document    2.9
    #Focus    /Window/Window/ToolBar[@Name="Object Bar"]
    #Focus    /Window/Window/ToolBar/Button[@Name="CommandButton"]
    #Drag And Drop    /Window/Window/ToolBar/Button[@Name="CommandButton"]    /Window/Pane[1]/Window/Pane
    #Click    /Window/Pane[1]/Window/Pane/Button[@Name="CmdButton1"]
    #Clear Blacklist
    #Clear Whitelist
    #Set Text To Textbox    /Window/Pane[1]/Window/Pane/Button[@Name="CmdButton1"]    Close
    Press Key    s'CTRL+F4'
    #Open the custom view

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
    Click    /Window/Pane[1]/Window/Pane/Button[@Name="Close"]
    #Need to set it for custom view as well

    
Close WinOpi
    Click    /Window/TitleBar/Button[@Name="Close"]

Open group view
    Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[1]/TreeItem[@Name="All Tanks"]
    Click    /Menu/MenuItem[@Name="View Group"]

Open all predefined Group views
    Open group view
    Press Key    s'DOWN'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    View Group - Group "All Tanks"
    Log To Console  Group view is opened
    Press Key    s'CTRL+F4'
    Open group view
    Press Key    s'UP'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Bargraph Group - Group "All Tanks"
    Log To Console  Bargraph group view is opened
    Press Key    s'CTRL+F4'
    
Modify existing Group
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Group Templates"]
    Click    /Window/Window/Pane/Button[@Name="Edit..."]
    Set Text To Textbox    /Window/Window/Window/Pane/Edit[1]    View Group test
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]

Create new Group
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Group Templates"]
    Click    /Window/Window/Pane/Button[@Name="New..."]
    Wait Until Element Exist    /Window/Window/Window[@Name="Edit Group Template"]
    Set Text To Textbox    /Window/Window/Window/Pane/Edit[1]    Test group
    Set Text To Textbox    /Window/Window/Window/Pane/Edit[2]    Test group demo
    Expand Combobox    /Window/Window/Window/Pane/ComboBox[1]
    Click    /Window/Window/Window/Pane/ComboBox[1]/List/ListItem[@Name="Table, show different tanks in different columns and rows"]
    Click    /Window/Window/Window/Pane/List/ListItem[@Name="Tank Type"]
    Click    /Window/Window/Window/Pane/Button[@Name="Select >"]
    Click    /Window/Window/Window/Pane/List/ListItem[@Name="Level"]
    Click    /Window/Window/Window/Pane/Button[@Name="Select >"]
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]
    Open group view
    Press Key    s'UP'
    Press Key    s'ENTER'
    ${Result}    Get Name From Element    /Window/Pane[1]/Window
    Should Be Equal    ${Result}    Test group demo - Group "All Tanks"
    Log To Console  Created group is opened
    Press Key    s'CTRL+F4'

Set default double-click action for Group
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox[2]
    Expand Combobox    /Window/Window/Pane/ComboBox[2]
    Click    /Window/Window/Pane/ComboBox[2]/List/ListItem[1][@Name="View Group"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]

Delete created group
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Group Templates"]
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Press Key    s'DOWN'
    Click    /Window/Window/Pane/Button[@Name="Delete"]
    Wait Until Element Exist    /Window/Window/Window[@Name="StmOpi"]
    Click    /Window/Window/Window/Button[@Name="Yes"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]

Delete modification done for existing group
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Group Templates"]
    Click    /Window/Window/Pane/Button[@Name="Edit..."]
    Set Text To Textbox    /Window/Window/Window/Pane/Edit[1]    View Group
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"]

Create custom view as copy of existing tank view
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Custom Views"]
    Click    /Window/Window/Pane/Button[@Name="Copy"]
    #FOR    ${index}     IN RANGE     1    15    
            #Press Key    s'DOWN'
            #${element_enabled}=    Is Element Enabled    /Window/Window/Pane/Button[@Name="Delete"]
            #Continue For Loop If    ${element_enabled}==True
            #Exit For Loop If    ${element_enabled}==False
    #END
    Click    /Window/Window/Button[@Name="OK"]

Create custom view from scratch 
    Click    /Window/ToolBar/Button[@Name="Program Options"]
    Wait Until Element Exist   /Window/Window[@Name="Operator's Interface Options"]
    Click    /Window/Window/Tab/TabItem[@Name="Custom Views"]
    Click    /Window/Window/Pane/Button[@Name="New"]
    Click    /Window/Window/Button[@Name="OK"]

Create Report
    #[Arguments]     ${reportName}       
    #Right Click    /Window/Pane[3]/Pane/Tree/TreeItem[@Name="Reports"]
    #Click    /Menu/MenuItem[@Name="Add Report"]
    #Wait Until Element Exist    /Window/Window[@Name="Report Data"]
    #Expand Combobox    /Window/Window/Pane/ComboBox[5]
    #Click    /Window/Window/Pane/ComboBox[5]/List/ListItem[@Name="${reportName}"]
    #Expand Combobox    /Window/Window/Pane/ComboBox[1]
    #Click    /Window/Window/Pane/ComboBox[1]/List/ListItem[@Name="Default"]
    #Select Radiobutton    /Window/Window/Pane/Button[@Name="Tank(s)"]
    #Click    /Window/Window/Pane/List[1]/ListItem[@Name="File"]
    #Click    /Window/Window/Pane/Button[@Name="Add >"]
    #Click    /Window/Window/Pane/Button[@Name="Config..."]
    ${SystemTime}    Get Time    mm:ss
    ${RequiredTime}    Split String    ${SystemTime}
    Split String From Right    ${RequiredTime[1]}    separator=:    max_split=-1
    Log To Console    ${RequiredTime[1]}

    

#Create Massbalance Report 

#Publish report and check the files

#Schedule report publication 


        
