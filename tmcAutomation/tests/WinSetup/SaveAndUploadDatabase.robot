*** Settings ***
Documentation     Save and upload database (wireless)     
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Tanks.resource
Resource    ../../resources/WinSetup/Devices.resource



*** Test Cases ***
Save and upload database  
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Save database
    #Check Tank Data
    Write Holding registers to SYSHUB-211 
    #Check Tank Data
    Upload database to device
    #Check Tank Data
    Delete database
    Close Winsetup
 