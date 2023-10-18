*** Settings ***
Resource    ../../resources/Setup.resource
Resource    ../../resources/WinSetup.resource
Suite Setup    Start App    
Suite Teardown    Close App

*** Test Cases ***
Setup Communication Protocol
    Start WinSetup
    WinSetup Logon
    Expand Tree
    Select Option from Right Click Menu            Protocols    MbMaster.1    Properties
    Modbus Properties
    
    