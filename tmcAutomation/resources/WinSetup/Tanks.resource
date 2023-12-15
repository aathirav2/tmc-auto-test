*** Settings ***
Documentation    Common functions across WinSetup application.
Resource    ../../resources/config.resource
Resource    ../../resources/WinSetup/Base.resource
Library    FlaUILibrary


*** Keywords ***
Install a Tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[@Name="Tanks"]
    Click    /Menu/MenuItem[@Name="Install New..."]
    Wait Until Element Exist    /Window/Window[@Name="General"]
    Press Key    s'HOME'   /Window/Window/Pane/ComboBox
    Expand Combobox    /Window/Window/Pane/ComboBox
    Click   /Window/Window/Pane/ComboBox/List/ListItem[1][@Name='Fixed Roof']
    Set Text To Textbox    /Window/Window/Pane/Edit    ${TK.Tag}
    Click    /Window/Window/Button[@Name="Next >"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem[@Name="${2460_A.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem[@Name="${2410_A.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Double Click    /Window/Window/Pane/Tree[1]/TreeItem/TreeItem/TreeItem[@Name="${LT_TK_1.Tag}"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Configuration"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Value Entry"]
    Click    /Window/Window/Button[@Name="Next >"]
    Wait Until Element Exist    /Window/Window[@Name="Summary"]
    Click    /Window/Window/Button[@Name="Finish"]
    Wait Until Element Exist    /Window/Window/Window[@Name="Rosemount TankMaster"]
    ${Result}    Get Name From Element    /Window/Window/Window/Text
    Should Be Equal    ${Result}    Tank ${TK.Tag} was successfully installed.
    Click    /Window/Window/Window/Button[@Name="OK"]
    Expand Tree structure

#Need to work on tables
#Check Tank Data
    #Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    #Click    /Menu/MenuItem[@Name="Open Tank View..."]
    #Wait Until Element Exist    /Window/Pane[1]/Window[@Name="This Workstation/${TK.Tag} - Tank View "]
    #Click    /Window/Pane[1]/Window/Text[2]/Pane[3]
    #${Result}    Get All Data From Grid    /Window/Pane[1]/Window/Text[2]/Pane[3]
    #Log To Console    ${Result}

Check Tree View
    ${Result}    Get All Visible Treeitems Names    /Window/Pane[2]/Pane/Tree
    IF    '${Result}[5]'=='${2460_A.Tag}' and '${Result}[6]'=='${2410_A.Tag}' and '${Result}[7]'=='${ATD_TK_1.Tag}' and '${Result}[8]' =='${LT_TK_1.Tag}'
        Log     Devices are displayed under appropriate tanks
    ELSE
        Fail    Devices are not displayed
    END
Remove any one device from tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    Click    /Menu/MenuItem[@Name="Properties"]
    Wait Until Element Exist    /Window/Window[@Name="Tank Configuration - ${TK.Tag}"]
    Click    /Window/Window/Tab/TabItem[@Name="Configuration"]
    Click    /Window/Window/Pane/Button[@Name="Change..."]
    Double Click    /Window/Window/Window/Pane/Tree[2]/TreeItem[@Name="${ATD_TK_1.Tag}"]
    Click    /Window/Window/Window/Pane/Button[@Name="OK"]
    Wait Until Element Exist    /Window/Window/Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Window/Window/Button[@Name="OK"]
    Click    /Window/Window/Button[@Name="Apply"] 
    Click    /Window/Window/Button[@Name="OK"]

Uninstall Tank
    Right Click    /Window/Pane[2]/Pane/Tree/TreeItem/TreeItem/TreeItem[1]/TreeItem[2]/TreeItem[@Name="${TK.Tag}"]
    Click    /Menu/MenuItem[@Name="Uninstall"]
    Wait Until Element Exist    /Window/Window[@Name="Rosemount TankMaster"]
    Click    /Window/Window/Button[@Name="Yes"]