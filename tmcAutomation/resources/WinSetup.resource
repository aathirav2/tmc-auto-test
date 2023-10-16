*** Settings ***
Documentation     [Setups for applications: WinSetup]
Resource    ../resources/Setup.resource
Library     ApplicationLibrary.DesktopLibrary
Library    OperatingSystem



*** Keywords ***
Start WinSetup
    Switch Application    Desktop
    ${Result}=    Run Keyword And Return Status    Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup    exact_match=${False}
    IF    ${Result} == True    # check if window exist, other wise open it
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup     exact_match=${False}
        #Wait For And Mouse Over And Click Element    name=WinSetup     exact_match=${False}
    ELSE
        Open Application    ${REMOTE_URL}     platformName=Windows    deviceName=Windows    app=${winSetup}    timeout=10
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=WinSetup    exact_match=${False}
        Sleep    1
        #Wait For And Mouse Over And Click Element    name=winSetup     exact_match=${False}
        
    END

WinSetup Logon
    ${Logon}=    Run Keyword And Return Status    Page Should Contain Element    name=Logon to TankMaster    #check if logon window is open
    IF    ${Logon}                                                  #logon window is open, login as admin, else open Logon window and login
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Clear Text    accessibility_id=28416                        #clear text if any from username field
        Input Text    accessibility_id=28416    ${username_admin}    #user name
        Clear Text    accessibility_id=28418                        #clear text if any from password field
        Input Password    accessibility_id=28418    admin           #password
        Click Element    name=OK

    ELSE
        Wait For And Click Element    name=Log on
        Wait For And Mouse Over And Click Element    name=Logon to TankMaster
        Input Text    accessibility_id=28416    ${username_admin}       #user name
        Input Password    accessibility_id=28418    admin           #password
        Click Element    name=OK
    
    END
    
    #Switch Application    Desktop
    #Wait For And Mouse Over And Click Element    name=Rosemount TankMaster WinSetup
    Wait For And Mouse Over And Click Element    accessibility_id=59393    # automation id of status bar 59393
    #Comment    Element Should Contain Text    accessibility_id=59393    administrator
    Wait For And Mouse Over And Click Element    name=administrator    # if it can find the user lever then it was succesfull login

    #Element Should Contain Text    name=ADMINISTRATOR    ADMINISTRATOR       #validates login

ExpandTree
    Comment    Send Keys    ${Keys.UP}    # a dummy move so that the pointer go to the tree instead of the status ar
    ${Result}=    Run Keyword And Return Status    Select Elements From Context Menu    xpath=//TreeItem[@Name=\"Network Connections\"]    name=Expand All
    Comment    Send Keys    \ue00c    #ESC
    IF    ${Result} == True
    Comment    Select Elements From Context Menu    xpath=//TreeItem[@Name=\"Network Connections\"]    name=Expand All
    log    Already expanded
    Send Keys    ${Keys.ESCAPE}    #ESC
    ELSE
    Switch Application    Desktop
    Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster WinSetup
    Sleep    2
    Wait For And Mouse Over And Click Element    name=Rosemount TankMaster WinSetup
    Select Elements From Context Menu    xpath=//TreeItem[@Name=\"Network Connections\"]    name=Collapse All
    Select Elements From Context Menu    xpath=//TreeItem[@Name=\"Network Connections\"]    name=Expand All
    END