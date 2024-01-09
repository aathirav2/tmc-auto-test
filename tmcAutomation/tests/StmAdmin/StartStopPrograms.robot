*** Settings ***
Documentation     Start and stop programs     
Resource    ../../resources/config.resource
Resource    ../../resources/StmAdmin/Base.resource
Resource    ../../resources/WinSetup/Base.resource
Resource    ../../resources/WinSetup/Devices.resource
Resource    ../../resources/WinSetup/Tanks.resource
Resource    ../../resources/WinOpi/Base.resource


*** Test Cases ***
Start and stop programs
    Start System Administrator
    #Switch Application to administrator
    Login to System Administrator
    Shut down all TM processes
    Start WinSetup using StmAdministrator
    Shut down all TM processes
    Start WinOpi using StmAdministrator
    Shut down all TM processes
    Start WinSetup
    Shut down all TM processes
    Start WinOpi
    #Switch Application to administrator
    Shut down all TM processes
    Close System administrator