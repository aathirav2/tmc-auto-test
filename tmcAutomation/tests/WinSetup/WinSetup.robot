*** Settings ***
Resource    ../../resources/Setup.resource
Resource    ../../resources/WinSetup.resource
Suite Setup    Start App    
Suite Teardown    Close App

*** Test Cases ***
Setup Communication Protocol
    Start WinSetup
    WinSetup Logon
    ExpandTree
    
    
    