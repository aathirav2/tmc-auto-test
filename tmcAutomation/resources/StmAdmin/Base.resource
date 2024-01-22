*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/config_credentials.resource
Library    FlaUILibrary
Library    OperatingSystem
Library    Process

*** Keywords ***
Start System administrator
    FlaUILibrary.Launch Application    ${stmAdmin} 
    Launch Application With Args    application    arguments
    Sleep    4
    #${window}    Get Window Interaction State    /Window[@Name="Rosemount TankMaster / Administrator Program on CLIENT57"]
    #Log To Console    ${window} #Ready for user interaction
    #Wait For Application Handle By Name       Rosemount TankMaster / Administrator Program on CLIENT57
    #${window} =     Get Window Visual State    /Window[@Name="Rosemount TankMaster / Administrator Program on CLIENT57"]     # Get the application window
    #Log To Console    ${window}#Minimized
    #Maximize Window    /Window[@Name="Rosemount TankMaster / Administrator Program on CLIENT57"]

Login to System administrator
    ${Logon}=    Run Keyword And Return Status    FlaUILibrary.Element Should Be Enabled    /Window/Button[@Name="Log on..."]
    IF    ${Logon}
        Click    /Window/Button[@Name="Log on..."]
        Set Text To Textbox    /Window/Window/Edit      ${password_admin}    
        Click    /Window/Window/Button[@Name="OK"] 
    ELSE
        Log To Console   Already Logged In
    END

Backup configuration
    Click    /Window/Button[@Name="Backup/Restore..."]
    Wait Until Element Exist    /Window/Window[@Name="Backup"]
    Set Text To Textbox   /Window/Window/Edit[@Name="Destination folder:"]     C:\\Rosemount\\TankMaster\\TMCAutomationBackUp   
    Click    /Window/Window/Button[@Name="Backup Now"]
    Wait Until Element Exist     /Window/Window/Window[@Name="StmAdministrator"]
    Click    /Window/Window/Window/Button[@Name="OK"]
    #User control pop up
    Sleep    4
    #Press Key  s'LEFT' 
    #Press Key  s'ENTER'               
    Wait Until Element Exist    /Window/Window/Window[@Name="StmAdministrator"]
    ${Result}    Get Name From Element    /Window/Window/Window/Text 
    Should Be Equal    ${Result}    Backup done!
    Click    /Window/Window/Window/Button[@Name="OK"]
    Wait Until Element Exist    /Window/Window[@Name="Backup"]
    Click    /Window/Window/Button[@Name="Close"]

Restore Backup
    Click    /Window/Button[@Name="Backup/Restore..."]
    Wait Until Element Exist    /Window/Window[@Name="Backup"]
    Click    /Window/Window/Button[@Name="Restore..."]
    Wait Until Element Exist    /Window/Window/Window[@Name="Restore Backup Wizard"]
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Click    /Window/Window/Window/Button[@Name="Browse..."]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="Browse For Folder"] 
    Click    /Window/Window/Window/Window/Pane[@Name="Locate the folder that contains the TankMaster backup data you want to restore."]
    Press Key    s'HOME'
    Right Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem[@Name="Desktop"] 
    Click    /Menu/MenuItem[@Name="Collapse"] 
    Right Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem[@Name="Desktop"] 
    Click    /Menu/MenuItem[@Name="Expand"] 
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[@Name="This PC"]
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[10]/TreeItem[@Name="Local Disk (C:)"]
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[10]/TreeItem[2]/TreeItem[@Name="Rosemount"]
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[10]/TreeItem[2]/TreeItem[11]/TreeItem[@Name="TankMaster"]
    Press Key    s'END'
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[10]/TreeItem[2]/TreeItem[11]/TreeItem/TreeItem[@Name="TMCAutomationBackUp"]
    Double Click    /Window/Window/Window/Window/Pane[1]/Tree/TreeItem/TreeItem[10]/TreeItem[2]/TreeItem[11]/TreeItem/TreeItem[13]/TreeItem
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Sleep    4
    Set Checkbox State      /Window/Window/Window/CheckBox[@Name="Delete old configuration files"]    ${True}
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="StmAdministrator"]
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="StmAdministrator"]
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    #User control pop up
    Sleep    4
    FlaUILibrary.Wait Until Element Is Enabled    /Window/Window/Window/Button[@Name="Copy Log"]
    Click    /Window/Window/Window/Button[@Name="Next >"]
    Click    /Window/Window/Window/Button[@Name="Finish"]
    Click    /Window/Window/Button[@Name="Close"]

Delete the backup file
    Empty Directory     C:\\Rosemount\\TankMaster\\TMCAutomationBackUp
    #Remove File    C:\\Rosemount\\TankMaster\\TMCAutomationBackUp\\TM Backup 6.G1 2023-12-21 07.51\\version

Shut down all TM processes
    Click    /Window/Button[@Name="Processes..."]
    Wait Until Element Exist    /Window/Window[@Name="Running TankMaster Processes"]
    Click    /Window/Window/Button[@Name="Shutdown TM"]
    Wait Until Element Exist    /Window/Window/Window[@Name="Administrator Warning"]
    Click    /Window/Window/Window/Button[@Name="Yes"]
    Sleep    3
    Click Hold    /Window/Window/Button[@Name="Close"]    3000

Start WinSetup using StmAdministrator
    Set Checkbox State    /Window/CheckBox[@Name="WinSetup"]    ${True}

Start WinOpi using StmAdministrator
    Set Checkbox State    /Window/CheckBox[@Name="WinOpi"]    ${True}

Debug and create report file
    ${Options}=    Run Keyword And Return Status    Element Should Exist    /Window/Button[@Name="More Options >>"]
    IF    ${Options}
        Click    /Window/Button[@Name="More Options >>"]
    END
    Click    /Window/Button[@Name="Debug Report..."]
    #Verify that all running TM processes are detected
    #Need to work on tables
    Click    /Window/Window/Button[@Name="Create Report File"]
    Sleep    60

Open debug report and check it
    Directory Should Not Be Empty    C:\\Rosemount\\TankMaster\\CrashLog
    #${Result}    Get File    C:\\Rosemount\\TankMaster\\CrashLog
    
    
Close System administrator
    ${LogOff}=    Run Keyword And Return Status    Element Should Exist     /Window/Button[@Name="Log off"]
    IF    ${LogOff} == True
        Click    /Window/Button[@Name="Log off"]
        Wait Until Element Exist    /Window/Window[@Name="StmAdministrator"]
        Click    /Window/Window/Button[@Name="Yes"]
    END
    Click    /Window/Button[@Name="Close"]
    