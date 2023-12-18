*** Settings ***
Documentation    WinSetup Device uninstallation wired       
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Devices.resource
Resource    ../../resources/WinSetup/Protocol.resource


*** Test Cases ***
WinSetup Device uninstallation
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Uninstall Field devices
    Uninstall Tank Hub
    Uninstall System Hub
    Uninstall Protocol
    Close Winsetup
 