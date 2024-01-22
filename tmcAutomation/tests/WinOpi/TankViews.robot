*** Settings ***
Documentation     Tank Views     
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Tank Views      
    Start WinOpi
    Login to WinOpi
    Accept the alarms
    Expand Tree structure
    Open all predefined tank views
    Create new tank view as copy of predefined view
    Create new tank view as copy of predefined view with modifications
    #Create new tank view from scratch
    Set default double-click action for tank
    Close WinOpi
 