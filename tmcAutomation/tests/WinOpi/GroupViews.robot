*** Settings ***
Documentation    Group Views     
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Group Views      
    Start WinOpi
    Login to WinOpi
    Accept the alarms
    Expand Tree structure
    Open all predefined Group views
    Modify existing Group
    Create new Group
    Delete modification done for existing group
    Set default double-click action for Group
    Delete created group
    Close WinOpi
 