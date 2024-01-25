*** Settings ***
Documentation    Alarms     
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Alarms      
    Start WinOpi
    Login to WinOpi
    Accept the alarms
    Expand Tree structure
    
    Close WinOpi
 