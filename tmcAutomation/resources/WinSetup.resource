*** Settings ***
Documentation     [Setups for applications: WinSetup]
Resource    ../resources/Setup.resource
Library     ApplicationLibrary.DesktopLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
${expandTree}    xpath=//TreeItem[@Name=\"Network Connections\"]

*** Keywords ***
Start WinSetup
    Switch Application    Desktop
    ${Result}=    Run Keyword And Return Status    Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup    exact_match=${False}
    IF    ${Result} == True    # check if window exist, other wise open it
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup     exact_match=${False}
        
    ELSE
        Open Application    ${REMOTE_URL}     platformName=Windows    deviceName=Windows    app=${winSetup}    timeout=10
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup    exact_match=${False}
        Sleep    1
    END
    
WinSetup Logon
    ${Logon}=    Run Keyword And Return Status    Page Should Contain Element    name=Logon to TankMaster    #check if logon window is open
    IF    ${Logon}                                                   #logon window is open, login as admin, else open Logon window and login
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Clear Text    accessibility_id=28416                         #clear text if any from username field
        Input Text    accessibility_id=28416    ${username_admin}    #user name
        Clear Text    accessibility_id=28418                         #clear text if any from password field
        Input Password    accessibility_id=28418    admin            #password
        Click Element    name=OK

    ELSE
        Wait For And Click Element    name=Log on
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Input Text    accessibility_id=28416    ${username_admin}       #user name
        Input Password    accessibility_id=28418    admin               #password
        Click Element    name=OK
    
    END
    
    Maximize Window
    Wait For And Mouse Over And Click Element    accessibility_id=59393    # automation id of status bar 59393
    Wait For And Mouse Over And Click Element    name=administrator        # if it can find the user lever then it was succesfull login

Expand Tree
    Comment    Send Keys    ${Keys.UP}    # a dummy move so that the pointer go to the tree instead of the status
    ${Result}=    Run Keyword And Return Status    Select Elements From Context Menu    ${expandTree}    name=Expand All
    IF    ${Result} == True
        log    Already expanded
        Send Keys    ${Keys.ESCAPE}    #ESC
    ELSE
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster WinSetup
        Sleep    2
        Wait For And Mouse Over And Click Element    name=Rosemount TankMaster WinSetup
        Select Elements From Context Menu    ${expandTree}    name=Collapse All
        Select Elements From Context Menu    ${expandTree}    name=Expand All
    END

Select Option from Right Click Menu
    [Arguments]     ${item_name1}    ${item_name2}    ${option_name}   
    Comment     "${item_name1}    ${item_name2}    ${option_name}"
    Select Elements From Menu    name=View    name=Toolbar
    Wait For And Mouse Over And Click Element    name=${item_name1}        #name=Protocols 
    Select Elements From Context Menu    name=${item_name2}    name=${option_name}        #name=MbMaster.1    name=Properties 
    Sleep    2
    

Modbus Properties
    Wait For And Mouse Over And Click Element    name=Modbus Master Protocol Channel 1 Configuration
    Wait For And Mouse Over And Click Element    name=Apply                        #applies Modbus properties
    Wait For And Mouse Over And Click Element    name=OK

Install New Device
    Select Elements From Context Menu    name=Devices    name=Install New...
    
Install 2460 System Hub
    Install New Device
    #Wait For And Mouse Over And Click Element    accessibility_id=28416
    Wait For And Mouse Over Element    accessibility_id=28416
    
    Select Element From ComboBox    accessibility_id=28416    name=${2460_A.DeviceType}    index=0
    Clear Text    accessibility_id=28417
    Input Text    accessibility_id=28417    ${2460_A.Tag}
    Wait For And Mouse Over And Click Element    name=Next >       #accessibility_id=28421
    Switch Application    Desktop
    Wait For And Mouse Over And Click Element    name=2460 System Hub Communication - ${2460_A.Tag}    timeout=15
    Wait For And Mouse Over And Click Element    accessibility_id=28421
    Clear Text    accessibility_id=28421            #name=Modbus Address:
    Input Text    accessibility_id=28421    ${2460_A.ModbusAddress}
    Wait For And Mouse Over And Click Element    name=Change Address...                   #button
    Wait For And Mouse Over And Click Element    name=Change Address                      #Dialog
    
    Send Keys    ${Keys.ALT}    d    ${Keys.ALT}    # ALT+d to enter device ID
    Send Keys    ${2460_A.DeviceID}
    #Wait For And Mouse Over And Click Element    name=Device ID:
    #Clear Text    name=Device ID:
    #Input Text    name=Device ID:    ${2460_A.DeviceID}  
    Wait For And Mouse Over And Click Element    name=OK  
    Wait For And Mouse Over And Click Element    name=Verify Communication                #accessibility_id=28426
    #Wait For And Mouse Over And Click Element    name=Rosemount TankMaster    exact_match=${True}
    Wait For And Mouse Over And Click Element    accessibility_id=65535    #name=Communication with 2460 System Hub is OK. 2460 System Hub version is 1.K1
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    #attributes names according to inspector.exe
    Should Contain    ${Result}    Communication with ${2460_A.DeviceType} is OK
    Wait For And Mouse Over And Click Element    name=OK                                  #accessibility_id=2
    Log    ${Result}
    Wait For And Mouse Over And Click Element    name=Next >    
    # Device port Configuration window
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # Tank Data base window
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # Redundancewindow
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # Summary window
    Wait For And Mouse Over And Click Element    name=Finish    # nothing to check / change at this stage
    # succesfull installation message
    Sleep    4
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    #attributes names according to inspector.exe
    Should Be Equal    ${Result}    The ${2460_A.DeviceType} ${2460_A.Tag} was successfully installed.
    Wait For And Mouse Over And Click Element    name=OK
    ExpandTree

Install 2410 Tank Hub
    Install New Device
    Wait For And Mouse Over And Click Element    accessibility_id=28416    
    Select Element From ComboBox    accessibility_id=28416    name=${2410_A.DeviceType}    index=2
    Clear Text    accessibility_id=28417
    Input Text    accessibility_id=28417    ${2410_A.Tag}
    Wait For And Mouse Over And Click Element    name=Next >       #accessibility_id=28421
    Switch Application    Desktop
    # Mouse Over Element    name=2410 Tank Hub Communication - ${2410_A.Tag}
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Communication - ${2410_A.Tag}    timeout=15        #accessibility_id=59648    
    # Wait For And Mouse Over And Click Element    name=Communication
    Click Button    name=Via 2460
    Wait For And Mouse Over And Click Element    name=Change Address on Device...                   #button
    Wait For And Mouse Over And Click Element    name=Change Address                                #Dialog
    Send Keys    ${Keys.ALT}    d    ${Keys.ALT}                                                    #ALT+d to enter device ID
    Send Keys    ${2410_A.DeviceID}                               #Automation ID 28423 - Device ID is duplicated with change address Button
    Log    ${2410_A.DeviceID}
    Send Keys    ${Keys.TAB}                                      #Automation ID 28416 - Modbus Address is duplicated with communication channel
    Send Keys    ${2410_A.ModbusAddress}
    Sleep    4s
    Wait For And Mouse Over And Click Element    name=OK
    Wait For And Mouse Over And Click Element    name=Verify Communication    timeout=10
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    #name=Communication with 2410 is OK, 2410 version: 1.G8
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    #attributes names according to inspector.exe
    Log    ${Result}
    Should Contain    ${Result}    Communication with 2410 is OK, 2410 version: ${2410_A.SWVer}
    Wait For And Mouse Over And Click Element    name=OK
    Wait For And Mouse Over And Click Element    accessibility_id=28423
    ${Result}=    Get Element Attribute    accessibility_id=28423    Value.Value    #attributes names according to inspector.exe
    Should Be Equal    ${Result}    ${2410_A.DeviceID}
    Log    ${Result}
    Wait For And Mouse Over And Click Element    name=Next >
    # 2410 Tank Data base window
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Tank Database - ${2410_A.Tag}    timeout=15
    Sleep    1
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # 2410 Tank Hub Device Tags
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Device Tags - ${2410_A.Tag}    timeout=15
    Sleep    1
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # 2410 Tank Hub Local Display
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Local Display - ${2410_A.Tag}    timeout=15
    Sleep    1
    Wait For And Mouse Over And Click Element    name=Next >    # nothing to check / change at this stage
    # 2410 Tank Hub Summary
    Wait For And Mouse Over And Click Element    name=2410 Tank Hub Summary - ${2410_A.Tag}    timeout=15
    Sleep    1
    Wait For And Mouse Over And Click Element    name=Finish    # nothing to check / change at this stage
    # check instruction message
    Sleep    15
    # information message validation
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name              #attributes names according to inspector.exe
    Should Contain    ${Result}    The device(s) will be automatically installed in TankMaster database. 
    # configuration information validation 
    Wait For And Mouse Over And Click Element    name=OK    Wait For And Mouse Over And Click Element    #name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535                
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name              #attributes names according to inspector.exe
    Should Contain    ${Result}    Configuration of value units has been changed and this requires an update of 2460 in TankServer database.
    Wait For And Mouse Over And Click Element    name=OK
    # check success message
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    #name=Communication with 2460 System Hub is OK.
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    #attributes names according to inspector.exe
    Should Be Equal    ${Result}    The 2410 HUB-101 was successfully installed.
    Wait For And Mouse Over And Click Element    name=OK
    ExpandTree   
    # information message validation
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name              #attributes names according to inspector.exe
    Should Contain    ${Result}    The device(s) will be automatically installed in TankMaster database. It is necessary to configure the device after the installation.
    Wait For And Mouse Over And Click Element    name=OK    timeout=10
    # check success message
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster
    Wait For And Mouse Over And Click Element    accessibility_id=65535    #name=Communication with 2460 System Hub is OK.
    ${Result}=    Get Element Attribute    accessibility_id=65535    Name    #attributes names according to inspector.exe
    Should Be Equal    ${Result}    The 2410 HUB-101 was successfully installed.
    Wait For And Mouse Over And Click Element    name=OK
    ExpandTree   
