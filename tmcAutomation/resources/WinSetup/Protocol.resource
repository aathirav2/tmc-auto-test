*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Library    FlaUILibrary


*** Keywords ***
Setup Protocol
    Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[3]/TreeItem[@Name="ModbusMaster 1.0"]
    Click    /Window/ToolBar/Button[@Name="Properties"]
    #MbMaster.1
    Click    /Window/Window/Pane/List/ListItem[1]
    Click    /Window/Window/Pane/Button[@Name="Properties..."]
    Set Checkbox State    /Window/Window/Window/Pane/CheckBox[@Name="Enable Channel"]    ${True}
    Click    /Window/Window/Window/Button[@Name="Apply"]
    Click Hold  /Window/Window/Window/Button[@Name="OK"]    1000
    Click Hold   /Window/Window/Pane/Button[@Name="Close"]    5000

Uninstall Protocol
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[3]/TreeItem[1]/TreeItem[@Name="MbMaster.1"]
    Click    /Menu/MenuItem[@Name="Properties"]
    Set Checkbox State    /Window/Window/Pane/CheckBox[1]    ${False}
    Click    /Window/Window/Button[@Name="Apply"]
    Click    /Window/Window/Button[@Name="OK"] 

Find Devices on Modbus
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[3]/TreeItem[1]/TreeItem[@Name="MbMaster.1"]
    Click    /Menu/MenuItem[@Name="Find Devices..."]
    Wait Until Element Exist    /Window/Window[@Name="Find Devices on MbMaster.1"]
    Click    /Window/Window/Pane/Button[@Name="Start"]
    Wait Until Element Is Enabled    /Window/Window/Pane/Button[@Name="Close"]    retries=30
    #${Result}    Get Name From Element    /Window/Window/Pane/DataGrid/DataItem[5]/Text[@Name="SYSHUB-210"]
    #Log To Console    ${Result}
    #Data grid issue needs to be solved
    #${Result}    Get All Data From Grid    /Window/Window/Pane/DataGrid/DataItem[1]
    #Should Be Equal    ${Result}    ${2410_A.Tag}
    grid