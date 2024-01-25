*** Settings ***
Documentation    Custom Views    
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Custom Views      
    #Start WinOpi
    #Login to WinOpi
    #Accept the alarms
    #Expand Tree structure
    Create custom view as copy of existing tank view
    Make modification in custom view
    Create custom view from scratch
    Edit created custom view from scratch 
    #Close WinOpi
 