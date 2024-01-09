*** Settings ***
Documentation     Debug report     
Resource    ../../resources/config.resource
Resource    ../../resources/StmAdmin/Base.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinOpi/Base.resource


*** Test Cases ***
Debug report
    Start System Administrator
    Login to System Administrator
    Start WinSetup using StmAdministrator
    Start WinOpi using StmAdministrator
    Debug and create report file
    #Open debug report and check it
    Close System administrator