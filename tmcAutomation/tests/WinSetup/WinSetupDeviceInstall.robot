*** Settings ***
Documentation    WinSetup Device installation wired       
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup.resource


*** Test Cases ***
WinSetup Device installation
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    Setup Protocol           
    Install 2460 System Hub
    Install 2410 Tank Hub
    Check communication to installed Devices    LT-TK-1    accessibility_id=28431
    Check communication to installed Devices    ATD-TK-1   accessibility_id=28432

 