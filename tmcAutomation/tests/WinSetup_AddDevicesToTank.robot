*** Settings ***
Documentation     Add devices to tanks wired      
Resource    ../resources/config.resource
Resource    ../resources/Winsetup.resource




*** Test Cases ***
Add devices to tank     
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Install a Tank
    #Check Tank Data
    Check Tree View
    Remove any one device from tank
    Uninstall Tank
    Close Winsetup
 