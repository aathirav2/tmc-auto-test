*** Settings ***
Documentation     Backup and restore from system administrator     
Resource    ../../resources/config.resource
Resource    ../../resources/StmAdmin/Base.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Devices.resource
Resource    ../../resources/WinSetup/Tanks.resource


*** Test Cases ***
Backup and restore
    Start System Administrator
    Login to System Administrator
    Backup configuration
    Close System administrator
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Uninstall Tank
    Uninstall Field devices
    Close Winsetup
    Start System Administrator
    Login to System Administrator
    Restore Backup
    Delete the backup file
    Close System administrator
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Check Tree View
    Close Winsetup