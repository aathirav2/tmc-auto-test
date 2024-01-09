*** Settings ***
Documentation     Find devices on channel (Modbus)    
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Tanks.resource
Resource    ../../resources/WinSetup/Devices.resource
Resource    ../../resources/WinSetup/Protocol.resource


*** Test Cases ***
Find devices on Modbus
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Find Devices on Modbus
    Close Winsetup
 