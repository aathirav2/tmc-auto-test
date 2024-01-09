*** Settings ***
Documentation     Tank Views     
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Tank Views      
    Start WinOpi
    Login to WinOpi
    Accept the alarms
    Close WinOpi
 