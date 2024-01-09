*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Library    FlaUILibrary
Library    OperatingSystem


*** Keywords ***
Install New Device
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[@Name="Devices"]
    Click    /Menu/MenuItem[@Name="Install New..."]

Install 2460 System Hub
    Install New Device
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox
    Expand Combobox    /Window/Window/Pane/ComboBox
    Click   /Window/Window/Pane/ComboBox/List/ListItem[1][@Name='2460 System Hub']  
    Set Text To Textbox    /Window/Window/Pane/Edit    ${2460_A.Tag}
    Click    /Window/Window/Pane/Button[@Name="Next >"]
    Click    /Window/Pane/Button[@Name="Change Address..."]
    Wait Until Element Exist    /Window/Window[@Name="Change Address"]
    Press Key    s'ALT+D'
    Press Key    s'${2460_A.DeviceID}'
    Press Key    s'TAB'
    Press Key    s'${2460_A.ModbusAddress}'
    Click Hold   /Window/Window/Pane/Button[@Name="OK"]    1000
    Wait Until Element Does Not Exist    /Window/Window[@Name="Change Address"]
    Click Hold   /Window/Pane/Button[@Name="Verify Communication"]    3000
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Text
    Should Contain    ${Result}    Communication with ${2460_A.DeviceType} is OK.
    Click Hold   /Window/Window/Button[@Name="OK"]    3000
    Click   /Window/Button[@Name="Next >"]      
    Wait Until Element Exist    /Window[@Name="2460 System Hub Configuration - SYSHUB-211"]  
    Click     /Window/Button[@Name="Next >"] 
    #Multiple loading popups are appearing due to which sleep is necessary
    Sleep    2
    Wait Until Element Exist    /Window[@Name="2460 System Hub Tank Database - SYSHUB-211"] 
    Click   /Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window[@Name="2460 System Hub Redundancy - SYSHUB-211"]
    Click    /Window/Button[@Name="Next >"]     
    Wait Until Element Exist    /Window[@Name="2460 System Hub Summary - SYSHUB-211"]
    Click    /Window/Button[@Name="Finish"]  
    Wait Until Element Exist    /Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Text 
    Should Be Equal    ${Result}    The ${2460_A.DeviceType} ${2460_A.Tag} was successfully installed.
    Click    /Window/Button[@Name="OK"]
    Expand Tree structure

Install 2410 Tank Hub
    Install New Device
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox
    Expand Combobox    /Window/Window/Pane/ComboBox
    Click   /Window/Window/Pane/ComboBox/List/ListItem[3][@Name='2410 Tank Hub']
    Set Text To Textbox    /Window/Window/Pane/Edit    ${2410_A.Tag}
    Click    /Window/Window/Pane/Button[@Name="Next >"]
    Click    /Window/Pane/Button[@Name="Via 2460"]
    Click    /Window/Pane/Button[@Name="Change Address on Device..."]
    Set Text To Textbox    /Window/Window/Pane/Edit    ${2410_A.DeviceID}
    Press Key    s'TAB'
    Press Key    s'${2410_A.ModbusAddress}'
    Click Hold  /Window/Window/Pane/Button[@Name="OK"]    1000
    Wait Until Element Does Not Exist    /Window/Window[@Name="Change Address"]
    Click Hold   /Window/Pane/Button[@Name="Verify Communication"]     3000
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"] 
    ${Result}     Get Name From Element    /Window/Window/Text 
    Should Contain    ${Result}    Communication with 2410 is OK, 2410 version: ${2410_A.SWVer} 
    Wait Until Element Exist        /Window/Window/Button[@Name="OK"]                                       
    Click Hold  /Window/Window/Button[@Name="OK"]    5000
    Click    /Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window[@Name="2410 Tank Hub Tank Database - HUB-110"]
    Click    /Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window[@Name="2410 Tank Hub Device Tags - HUB-110"]
    Click    /Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window[@Name="2410 Tank Hub Local Display - HUB-110"]
    Click    /Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window[@Name="2410 Tank Hub Summary - HUB-110"]
    Click    /Window/Button[@Name="Finish"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]   
    ${Result}    Get Name From Element    /Window/Window/Text 
    Should Contain    ${Result}    The device(s) will be automatically installed in TankMaster database.
    Click    /Window/Window/Button[@Name="OK"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Text  
    Should Contain    ${Result}    Configuration of value units has been changed and this requires an update of 2460 in TankServer database.
    Click    /Window/Window/Button[@Name="OK"]
    Wait Until Element Exist    /Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Text 
    Should Be Equal    ${Result}    The 2410 ${2410_A.Tag} was successfully installed.
    Click    /Window/Button[@Name="OK"]
    Expand Tree structure
    
Check communication to LT-TK-1 
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #Multiple loading popups are appearing due to which sleep is necessary
    Sleep    15  
    Click   /Window/Window/Pane/Button[@Name="Change..."] 
    ${Result}=    Run Keyword And Return Status   Element Should Exist    /Window/Window/Window[@Name="Rosemount TankMaster"]
    Log To Console    ${Result}
    IF    ${Result} == True
        Click    /Window/Window/Window/Button[@Name="Yes"]
    END 
    Click    /Window/Window/Window/Pane/Button[@Name="Verify Communication"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Window/Text 
    Should Be Equal    ${Result}    Communication with 5900S RLG is OK
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    Click     /Window/Window/Window/Pane/Button[@Name="OK"] 
    Click Hold   /Window/Window/Button[@Name="Apply"]   5000
    Click Hold    /Window/Window/Button[@Name="OK"]    2000 

Check communication to ATD-TK-1
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #Multiple loading popups are appearing due to which sleep is necessary
    Sleep    30
    Click      /Window/Window/Pane/Button[@Name="Change..."]   
    Wait Until Element Exist    /Window/Window/Window[@Name="22XX ATD Communication"]
    Click    /Window/Window/Window/Pane/Button[@Name="Verify Communication"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Window/Text 
    Should Be Equal    ${Result}    Communication with 22XX ATD is OK
    Click   /Window/Window/Window/Window/Button[@Name="OK"]    
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Click Hold   /Window/Window/Button[@Name="Apply"]   5000
    Click Hold    /Window/Window/Button[@Name="OK"]    2000

Uninstall Field devices
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]

Uninstall Tank Hub
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]

Uninstall System Hub
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]

Save database
    Right Click   /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="Save Database to File..."]
    Wait Until Element Exist    /Window/Window[@Name="Save Database to File - SYSHUB-211 (Version 1.M0)"]
    ${Folder}    Get Name From Element    /Window/Window/Pane/Edit[3]
    Set Global Variable    ${Folder}
    Log To Console    ${Folder}
    Expand Combobox    /Window/Window/Pane/ComboBox[1]
    Click   /Window/Window/Pane/ComboBox[1]/List/ListItem[@Name='Holding Registers']
    Expand Combobox    /Window/Window/Pane/ComboBox[2]
    Click   /Window/Window/Pane/ComboBox[2]/List/ListItem[@Name='Basic Registers']  
    Click    /Window/Window/Pane/Button[@Name="Save"]
    #Time for saving, implicit wait not working
    Sleep    30
    Wait Until Element Exist    /Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Text 
    Should Be Equal    ${Result}    Operation completed!
    Click    /Window/Window/Window/Button[@Name="OK"]
    Click    /Window/Window/TitleBar/Button[@Name="Close"]

Write Holding registers to SYSHUB-211
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - SYSHUB-211 (Version 1.M0)"]
    Set Text To Textbox    /Window/Window/Pane/Edit[1]    100
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Check the value 45
    #Double click action not possible
    Double Click    /Window/Window/Pane/Pane/Pane[1]
    Expand Combobox    /Window/Window/Window/Pane/ComboBox
    Click   /Window/Window/Window/Pane/ComboBox/List/ListItem[@Name='ft']
    Click    /Window/Window/Window/Pane/Button[@Name='OK']
    #Check the value 44
    Click    /Window/Window/Pane/Button[@Name='Apply']
    Click    /Window/Window/Pane/Button[@Name='Close']

Write Holding registers to HUB-110
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - HUB-110 (Version 1.H3)"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Double click action not possible
    #Double Click    /Window/Window/Pane/Pane/Pane[1]
    Wait Until Element Exist    /Window/Window/Window[@Name='Expanded enum - 100, TankConfig-Dev1_DevType']
    Expand Combobox    /Window/Window/Window/Pane/ComboBox
    #Click   /Window/Window/Window/Pane/ComboBox/List/ListItem[@Name='ft']
    Click    /Window/Window/Window/Pane/Button[@Name='OK']
    Click    /Window/Window/Pane/Button[@Name='Apply']
    Click    /Window/Window/Pane/Button[@Name='Close']

Write Holding registers to ATD_TK_1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - ATD-TK-1"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Double click action not possible
    #Double Click    /Window/Window/Pane/Pane/Pane[1]
    Expand Combobox    /Window/Window/Window/Pane/ComboBox
    #Click   /Window/Window/Window/Pane/ComboBox/List/ListItem[@Name='ft']
    Click    /Window/Window/Window/Pane/Button[@Name='OK']
    Click    /Window/Window/Pane/Button[@Name='Apply']
    Click    /Window/Window/Pane/Button[@Name='Close']

Write Holding registers to LT_TK_1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - LT-TK-1 (Version 1.B5)"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Double click action not possible
    #Double Click    /Window/Window/Pane/Pane/Pane[1]
    Expand Combobox    /Window/Window/Window/Pane/ComboBox
    #Click   /Window/Window/Window/Pane/ComboBox/List/ListItem[@Name='ft']
    Click    /Window/Window/Window/Pane/Button[@Name='OK']
    Click    /Window/Window/Pane/Button[@Name='Apply']
    Click    /Window/Window/Pane/Button[@Name='Close']

Upload database to device
    Right Click   /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="Upload Database..."] 
    Wait Until Element Exist    /Window/Window[@Name="Upload Database - SYSHUB-211, (Version 1.M0)"]
    Click    /Window/Window/Pane/Button[@Name='Browse...']
    Set Text To Textbox    /Window/Window/Window/ComboBox[1]/Edit    ${Folder}
    Click    /Window/Window/Window/Button[@Name='Open']
    Click    /Window/Window/Window/Pane[1]/Pane[2]/List/ListItem/Edit[1]
    Click    /Window/Window/Window/Button[@Name='Open']
    #${fileName}    Get Name From Element    /Window/Window/Pane/Edit
    #Set Global Variable    ${fileName}
    Click    /Window/Window/Pane/Button[@Name='Upload']
    #Time for uploading
    Sleep	1 minute 30 seconds 
    Wait Until Element Exist    /Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Text
    Should Be Equal    ${Result}    Operation completed, data written successfully!
    Click    /Window/Window/Window/Button[@Name="OK"]
    Click    /Window/Window/TitleBar/Button[@Name="Close"]

Delete database
    Log To Console    ${Folder}
    Empty Directory     ${Folder}  
    
View input registers for SYSHUB-211
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Input Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Input Registers - SYSHUB-211 (Version 1.M0)"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View input registers for HUB-110
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem[@Name="${2410_A.Tag}"] 
    Click    /Menu/MenuItem[@Name="View Input Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Input Registers - HUB-110 (Version 1.H3)"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View input registers for ATD-TK-1  
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"] 
    Click    /Menu/MenuItem[@Name="View Input Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Input Registers - ATD-TK-1"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View input registers for LT-TK-1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"] 
    Click    /Menu/MenuItem[@Name="View Input Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Input Registers - LT-TK-1 (Version 1.B5)"]
    Expand Combobox    /Window/Window/Pane/ComboBox[4]
    #Click    /Window/Window/Pane/ComboBox[4]/List/ListItem[@Name="[0] Tank1-Level"]
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View holding registers for SYSHUB-211
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - SYSHUB-211 (Version 1.M0)"]
    Set Text To Textbox    /Window/Window/Pane/Edit[1]    100
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values #Check the value 45
    Click    /Window/Window/Pane/Button[@Name="Close"]

View holding registers for HUB-110
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - HUB-110 (Version 1.H3)"]
    Set Text To Textbox    /Window/Window/Pane/Edit[1]    100
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values #Check the value 8768
    Click    /Window/Window/Pane/Button[@Name="Close"]

View holding registers for ATD-TK-1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - ATD-TK-1"]
    #Set Text To Textbox    /Window/Window/Pane/Edit[1]    100
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values #Check the value 45
    Click    /Window/Window/Pane/Button[@Name="Close"]

View holding registers for LT-TK-1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"] 
    Click    /Menu/MenuItem[@Name="View Holding Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Holding Registers - LT-TK-1 (Version 1.B5)"]
    #Set Text To Textbox    /Window/Window/Pane/Edit[1]    100
    Click    /Window/Window/Pane/Button[@Name="Read"]
    #Read the values #Check the value 45
    Click    /Window/Window/Pane/Button[@Name="Close"]

View diagnostic registers for SYSHUB-211  
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem[@Name="${2460_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Diagnostic Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Diagnostic Registers - SYSHUB-211 (Version 1.M0)"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View diagnostic registers for HUB-110
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Click    /Menu/MenuItem[@Name="View Diagnostic Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Diagnostic Registers - HUB-110 (Version 1.H3)"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View diagnostic registers for ATD-TK-1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="View Diagnostic Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Diagnostic Registers - ATD-TK-1"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]

View diagnostic registers for LT-TK-1
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Menu/MenuItem[@Name="View Diagnostic Registers..."]
    Wait Until Element Exist    /Window/Window[@Name="View Diagnostic Registers - LT-TK-1 (Version 1.B5)"]
    #Read the values
    Click    /Window/Window/Pane/Button[@Name="Close"]
