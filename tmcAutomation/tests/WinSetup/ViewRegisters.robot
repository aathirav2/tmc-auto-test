*** Settings ***
Documentation     View registers (wireless)    
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Tanks.resource
Resource    ../../resources/WinSetup/Devices.resource



*** Test Cases ***
View registers
    Start WinSetup
    Login to WinSetup
    Expand Tree structure
    View input registers for SYSHUB-211
    View input registers for HUB-110
    View input registers for ATD-TK-1
    View input registers for LT-TK-1
    View holding registers for SYSHUB-211
    View holding registers for HUB-110
    View holding registers for ATD-TK-1
    View holding registers for LT-TK-1
    View diagnostic registers for SYSHUB-211
    View diagnostic registers for HUB-110
    View diagnostic registers for ATD-TK-1
    View diagnostic registers for LT-TK-1 
    Write Holding registers to SYSHUB-211  
    Write Holding registers to HUB-110
    Write Holding registers to ATD_TK_1
    Write Holding registers to LT_TK_1
    Close Winsetup
 