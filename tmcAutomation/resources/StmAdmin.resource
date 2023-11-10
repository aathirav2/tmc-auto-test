*** Settings ***
Resource    ../resources/Setup.resource
Library     ApplicationLibrary.DesktopLibrary


*** Keywords ***
Open Administrator Program

    Switch Application    Desktop
    ${Result}=    Run Keyword And Return Status    Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster / Administrator Program    exact_match=${False}
    IF    ${Result} == True    # check if window exist, other wise open it
        Switch Application    Desktop
        Switch Application By Name    ${REMOTE_URL}    window_name=Rosemount TankMaster / Administrator Program     exact_match=${False}
        Comment    ApplicationLibrary.DesktopLibrary.Wait For And Mouse Over And Click Element    xpath=//ToolBar[@ClassName=\"MSTaskListWClass\"][@Name=\"Running applications\"]/Button[@Name=\"TankMaster/Administrator - 1 running window\"][@AutomationId=\"C:\\Rosemount\\TankMaster\\Server\\StmAdministrator.exe\"]
        Wait For And Mouse Over And Click Element    name=Rosemount TankMaster / Administrator Program     exact_match=${False}
    ELSE
        
        Run    ${StmAdmin}
        Switch Application    Desktop
        Sleep    1
        Wait For And Mouse Over And Click Element    name=TankMaster/Administrator - 1 running window       timeout=5
        Wait For And Mouse Over And Click Element    name=Log on...
        Send Keys    admin
        Send Keys    ${Keys.ENTER}
        Wait Until Element Is Visible    name=Log off
        Wait Until Element Is Enabled    name=Log off
        Wait For And Mouse Over And Click Element    name=Processes...
        Send Keys    ${Keys.ESCAPE}   #ESC
    END
    Sleep    2