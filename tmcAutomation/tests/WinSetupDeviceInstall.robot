*** Settings ***
Documentation    WinSetup Device installation wired       
Resource    ../resources/config.resource
Resource    ../resources/WinSetup/Base.resource
Resource    ../resources/WinSetup/Devices.resource
Resource    ../resources/WinSetup/Protocol.resource


*** Test Cases ***
WinSetup Device installation
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Setup Protocol          
    Install 2460 System Hub
    Install 2410 Tank Hub
    Check communication to LT-TK-1       
    Check communication to ATD-TK-1
    Close Winsetup
 