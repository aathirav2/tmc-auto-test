*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../resources/config.resource
Resource    ../resources/config_credentials.resource
Library    FlaUILibrary

*** Variables ***
${Result}
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

Setup Protocol
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[3]/TreeItem[@Name="ModbusMaster 1.0"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #MbMaster.1
    Click    /Window/Window/Pane/List/ListItem[1]
    Click    /Window/Window/Pane/Button[@Name="Properties..."]
    Set Checkbox State    /Window/Window/Window/Pane/CheckBox[@Name="Enable Channel"]    ${True}
    Click    /Window/Window/Window/Button[@Name="Apply"]
    Click Hold  /Window/Window/Window/Button[@Name="OK"]    1000
    Click Hold   /Window/Window/Pane/Button[@Name="Close"]    5000

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
    #Multiple loading popups are appearing
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
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="LT-TK-1"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #Sleep need to be put here as default time outs are not working due to multiple pop ups.
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
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[2]/TreeItem/TreeItem/TreeItem[@Name="ATD-TK-1"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #Sleep need to be put here as default time outs are not working due to multiple pop ups.
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

Install a Tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[@Name="Tanks"]
    Click    /Menu/MenuItem[@Name="Install New..."]
    Wait Until Element Exist    /Window/Window[@Name="General"]
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox
    Expand Combobox    /Window/Window/Pane/ComboBox
    Click   /Window/Window/Pane/ComboBox/List/ListItem[1][@Name='Fixed Roof']
    Set Text To Textbox    /Window/Window/Pane/Edit    ${TK.Tag}
    Click    /Window/Window/Button[@Name="Next >"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem[@Name="${2460_A.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Configuration"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Value Entry"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Summary"]
    Click    /Window/Window/Button[@Name="Finish"]
    Wait Until Element Exist    /Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Text
    Should Be Equal    ${Result}    Tank ${TK.Tag} was successfully installed.
    Click    /Window/Window/Window/Button[@Name="OK"]
    Expand Tree structure

#Need to work on tables
#Check Tank Data
    #Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    #Click    /Menu/MenuItem[@Name="Open Tank View..."]
    #Wait Until Element Exist    /Window/Pane[1]/Window[@Name="This Workstation/${TK.Tag} - Tank View "]
    #Click    /Window/Pane[1]/Window/Text[2]/Pane[3]
    #${Result}    Get All Data From Grid    /Window/Pane[1]/Window/Text[2]/Pane[3]
    #Log To Console    ${Result}

Check Tree View
    ${Result}    Get All Visible Treeitems Names    /Window/Pane[2]/Pane/Tree
    IF    '${Result}[5]'=='${2460_A.Tag}' and '${Result}[6]'=='${2410_A.Tag}' and '${Result}[7]'=='${ATD_TK_1.Tag}' and '${Result}[8]' =='${LT_TK_1.Tag}'
        Log     Devices are displayed under appropriate tanks
    ELSE
        Fail    Devices are not displayed
    END
Remove any one device from tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    Click    /Menu/MenuItem[@Name="Properties"]
    Wait Until Element Exist    /Window/Window[@Name="Tank Configuration - ${TK.Tag}"]
    Click    /Window/Window/Tab/TabItem[@Name="Configuration"]
    Click    /Window/Window/Pane/Button[@Name="Change..."]
    Double Click    /Window/Window/Window/Pane/Tree[2]/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    Click    /Window/Window/Button[@Name="Apply"] 
    Click    /Window/Window/Button[@Name="OK"]

Uninstall Tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]

Close Winsetup
    Click    /Window/TitleBar/Button[@Name="Close"]