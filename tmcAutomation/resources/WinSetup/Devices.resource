*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Library    FlaUILibrary


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