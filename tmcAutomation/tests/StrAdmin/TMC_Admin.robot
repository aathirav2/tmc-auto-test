*** Settings ***
Resource    ../../resources/Setup.resource
Suite Setup    Start App    
Suite Teardown    Close App

*** Variables ***


*** Keywords ***

*** Test Cases ***
Open Administrator Program
    # find a way to run (win+R) then paste the path    "C:\Rosemount\TankMaster\Server\StmAdministrator.exe"
    # check that tank server status is always PRIMARY
    Switch Application    Desktop
    ${Result}=    Run Keyword And Return Status    Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster / Administrator Program    exact_match=${False}
    IF    ${Result} == True    # check if window exist, other wise open it
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster / Administrator Program     exact_match=${False}
        Comment    ApplicationLibrary.DesktopLibrary.Wait For And Mouse Over And Click Element    xpath=//ToolBar[@ClassName=\"MSTaskListWClass\"][@Name=\"Running applications\"]/Button[@Name=\"TankMaster/Administrator - 1 running window\"][@AutomationId=\"C:\\Rosemount\\TankMaster\\Server\\StmAdministrator.exe\"]
        Wait For And Mouse Over And Click Element    name=Rosemount TankMaster / Administrator Program     exact_match=${False}
    ELSE
        
        # Wait For And Mouse Over And Click Element    name=Show desktop
        Run    ${StmAdmin}
        Switch Application    Desktop
        #Switch Application By Locator    ${REMOTE_URL}    name=TankMaster/Administrator     exact_match=${False}
        #Wait For And Mouse Over And Click Element    xpath=//ToolBar[@ClassName=\"MSTaskListWClass\"][@Name=\"Running applications\"]/Button[@Name=\"TankMaster/Administrator - 1 running window\"][@AutomationId=\"C:\\Rosemount\\TankMaster\\Server\\StmAdministrator.exe\"]
        Sleep    1
        #Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster / Administrator Program     exact_match=${False}
        Wait For And Mouse Over And Click Element    name=TankMaster/Administrator - 1 running window       timeout=5
        Wait For And Mouse Over And Click Element    name=Log on...
        #Switch Application By Locator    ${REMOTE_URL}    window_name=Logon to Administrator Program
        Send Keys    admin
        Send Keys    ${Keys.ENTER}
        Wait Until Element Is Visible    name=Log off
        Wait Until Element Is Enabled    name=Log off
        Wait For And Mouse Over And Click Element    name=Processes...
        



        Send Keys    ${Keys.ESCAPE}   #ESC
    END
    Sleep    2


#Logon Administrator
    
    
    #Open Application     ${REMOTE_URL}    platformName=Windows    deviceName=Windows    app=${stmAdmin}    window_name=Rosemount TankMaster / Administrator Program    exact_match=${False}
     

    