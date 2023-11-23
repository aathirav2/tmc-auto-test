*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../resources/config.resource
Resource    ../resources/config_credentials.resource
Library     ApplicationLibrary.DesktopLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${expandTree}    xpath=//TreeItem[@Name=\"Network Connections\"]



*** Keywords ***
Start WinSetup
    Open Application    ${REMOTE_URL}     platformName=Windows    deviceName=Windows    app=${winSetup}  
    Switch Application    Desktop
    Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup    exact_match=${False}
    
Login to WinSetup
    #check if logon window is open: if open, login as admin else open Logon window and login
    ${Logon}=    Run Keyword And Return Status    Page Should Contain Element    name=Logon to TankMaster    
    IF    ${Logon}                                                                                         
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Clear Text    accessibility_id=28416                                                                 
        Input Text    accessibility_id=28416    ${username_admin}                                            
        Clear Text    accessibility_id=28418                                                                 
        Input Password    accessibility_id=28418    ${password_admin}                                        
        Click Element    name=OK

    ELSE
        Wait For And Click Element    name=Log on
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Input Text    accessibility_id=28416    ${username_admin}                                            
        Input Password    accessibility_id=28418    ${password_admin}                                        
        Click Element    name=OK
    END
    
    Maximize Window
    # automation id of status bar 59393
    Wait For And Mouse Over And Click Element    accessibility_id=59393  
    # if it can find the user lever then it was successful login                                     
    Wait For And Mouse Over And Click Element    name=${username_admin}                                       

Expand Tree structure
    # a dummy move so that the pointer go to the tree instead of the status
    Comment    Send Keys    ${Keys.UP}                                                                         
    ${Result}=    Run Keyword And Return Status    Select Elements From Context Menu    ${expandTree}    name=Expand All
    IF    ${Result} == True
        Log    Already expanded
        Send Keys    ${Keys.ESCAPE} 
    ELSE
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster WinSetup
        Wait Until Page Contains Element     name=Rosemount TankMaster WinSetup     timeout=20
        Wait For And Mouse Over And Click Element    name=Rosemount TankMaster WinSetup
        Select Elements From Context Menu    ${expandTree}    name=Collapse All
        Select Elements From Context Menu    ${expandTree}    name=Expand All
    END

Setup Protocol
    Wait For And Mouse Over Element    name=Protocols
    Mouse Over And Context Click Element  name=ModbusMaster 1.0                                               
    Wait For And Mouse Over And Click Element    name=Properties 
    Wait Until Page Contains Element     name=ModbusMaster Protocol Properties     timeout=20
    Wait For And Mouse Over And Click Element    name=1    #MbMaster.1
    Wait For And Mouse Over And Click Element    name=Properties...
    Wait Until Page Contains Element     name=Modbus Master Protocol Channel 1 Configuration     timeout=20
    Wait For And Mouse Over And Click Element    name=Enable Channel
    Wait For And Mouse Over And Click Element    name=Apply    timeout=30                                             
    Wait For And Mouse Over And Click Element    name=OK       timeout=30
    Wait For And Mouse Over And Click Element    accessibility_id=28418    timeout=30

Install New Device
    Select Elements From Context Menu    name=Devices    name=Install New...
    
Install 2460 System Hub
    Install New Device
    Wait For And Mouse Over Element    accessibility_id=28416
    Select Element From ComboBox    accessibility_id=28416    name=${2460_A.DeviceType}    index=0
    Clear Text    accessibility_id=28417
    Input Text    accessibility_id=28417    ${2460_A.Tag}
    Wait For And Mouse Over And Click Element    name=Next >                           
    Switch Application    Desktop
    Wait For And Mouse Over And Click Element    name=2460 System Hub Communication - ${2460_A.Tag}    timeout=15
    #name=Modbus Address
    Wait For And Mouse Over And Click Element    accessibility_id=28421
    Clear Text    accessibility_id=28421            
    Input Text    accessibility_id=28421    ${2460_A.ModbusAddress}
    #Change address button
    Wait For And Mouse Over And Click Element    name=Change Address...
    #Change address Dialog   
    Wait For And Mouse Over And Click Element    name=Change Address   
    # ALT+d to enter device ID                   
    Send Keys    ${Keys.ALT}    d    ${Keys.ALT}                                          
    Send Keys    ${2460_A.DeviceID} 
    Wait For And Mouse Over And Click Element    name=OK  
    Wait For And Mouse Over And Click Element    name=Verify Communication                
    Wait For And Mouse Over And Click Element    accessibility_id=65535                   
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name                 
    Should Contain    ${Result}    Communication with ${2460_A.DeviceType} is OK
    Wait For And Mouse Over And Click Element    name=OK                                  
    Log    ${Result}
    Wait For And Mouse Over And Click Element    name=Next >    
    # Device port Configuration window
    Wait For And Mouse Over And Click Element    name=Next >                               
    # Tank Data base window
    Wait For And Mouse Over And Click Element    name=Next >                               
    # Redundancewindow
    Wait For And Mouse Over And Click Element    name=Next >                               
    # Summary window
    Wait For And Mouse Over And Click Element    name=Finish                               
    # Succesfull installation message
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster    timeout=4
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name                  
    Should Be Equal    ${Result}    The ${2460_A.DeviceType} ${2460_A.Tag} was successfully installed.
    Wait For And Mouse Over And Click Element    name=OK
    Expand Tree structure

Install 2410 Tank Hub
    Install New Device
    Wait For And Mouse Over Element    accessibility_id=28416     timeout=10
    Select Element From ComboBox    accessibility_id=28416    name=${2410_A.DeviceType}    index=2
    Wait Until Page Contains Element     accessibility_id=28417     timeout=20
    Clear Text    accessibility_id=28417
    Input Text    accessibility_id=28417    ${2410_A.Tag}
    Wait For And Mouse Over And Click Element    name=Next >                                       
    Switch Application    Desktop
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Communication - ${2410_A.Tag}    timeout=15        
    Click Button    name=Via 2460
    Wait For And Mouse Over And Click Element    name=Change Address on Device...                   
    Wait For And Mouse Over And Click Element    name=Change Address         timeout=15             
    Send Keys    ${Keys.ALT}    d    ${Keys.ALT}                                                    
    Send Keys    ${2410_A.DeviceID}                                                                 
    Send Keys    ${Keys.TAB}                                                                        
    Send Keys    ${2410_A.ModbusAddress}
    Wait Until Page Contains Element     name=OK     timeout=20
    Wait For And Mouse Over And Click Element    name=OK
    Wait For And Mouse Over And Click Element    name=Verify Communication    timeout=10
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535                             
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name                           
    Log    ${Result}
    Should Contain    ${Result}    Communication with 2410 is OK, 2410 version: ${2410_A.SWVer}
    Wait For And Mouse Over And Click Element    name=OK
    Wait For And Mouse Over And Click Element    accessibility_id=28423
    ${Result}=    Get Element Attribute    accessibility_id=28423    Value.Value                    
    Should Be Equal    ${Result}    ${2410_A.DeviceID}
    Log    ${Result}
    Wait For And Mouse Over And Click Element    name=Next >
    # 2410 Tank Data base window
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Tank Database - ${2410_A.Tag}    timeout=15
    Wait Until Page Contains Element     name=Next >     timeout=20
    Wait For And Mouse Over And Click Element    name=Next >    
    # 2410 Tank Hub Device Tags
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Device Tags - ${2410_A.Tag}    timeout=15
    Wait Until Page Contains Element     name=Next >     timeout=20
    Wait For And Mouse Over And Click Element    name=Next >    
    # 2410 Tank Hub Local Display
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Local Display - ${2410_A.Tag}    timeout=15
    Wait Until Page Contains Element     name=Next >     timeout=20
    Wait For And Mouse Over And Click Element    name=Next >    
    # 2410 Tank Hub Summary
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Summary - ${2410_A.Tag}    timeout=15
    Wait Until Page Contains Element     name=Finish     timeout=20
    Wait For And Mouse Over And Click Element    name=Finish    
    # check instruction message
    Wait Until Page Contains Element     name=Rosemount TankMaster     timeout=20
    # information message validation
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster    timeout=15
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name              
    Log    ${Result}
    Should Contain    ${Result}    The device(s) will be automatically installed in TankMaster database.
    Wait For And Mouse Over And Click Element    name=OK  
    #configuration information validation    
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster    timeout=15
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name              
    Log    ${Result}
    Should Contain    ${Result}        Configuration of value units has been changed and this requires an update of 2460 in TankServer database.  
    Wait Until Page Contains Element     name=OK     timeout=20
    Wait For And Mouse Over And Click Element    name=OK 
    # check success message
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster    timeout=15
    Wait For And Mouse Over And Click Element    accessibility_id=65535      
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    
    Log   ${Result}
    Should Be Equal    ${Result}    The 2410 ${2410_A.Tag} was successfully installed.
    Wait For And Mouse Over And Click Element    name=OK
    Expand Tree structure


Check communication to installed Devices
    [Arguments]     ${device_name1}    ${device_message} 
    Comment     "${device_name1}    ${device_message}"
    Wait For And Mouse Over And Click Element    name=${device_name1}              timeout=30                             
    Select Elements From Context Menu    name=${device_name1}    accessibility_id=32821                   
    Wait For And Mouse Over Element    accessibility_id=12321     timeout=40
    Wait Until Page Contains Element     accessibility_id=12321     timeout=40
    Wait For And Mouse Over And Click Element    accessibility_id=12321    timeout=40  
    Wait For And Mouse Over And Click Element    ${device_message}    timeout=30
    ${Result}=    Get Element Attribute    ${device_message}   Value.Value
    Log To Console  ${Result}
    Should Contain    ${Result}        Device is configured.  
    Wait For And Click Element    name=OK                    timeout=30
    
   
