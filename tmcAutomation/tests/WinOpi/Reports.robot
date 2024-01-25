*** Settings ***
Documentation    Reports   
Resource    ../../resources/config.resource
Resource    ../../resources/WinOpi/Base.resource




*** Test Cases ***
Reports      
    #Start WinOpi
    #Login to WinOpi
    #Accept the alarms
    #Expand Tree structure
    Create Report    
    #Create Report    MassBalanceReport
    #Publish report and check the files
    #Schedule report publication 
    #Close WinOpi
 