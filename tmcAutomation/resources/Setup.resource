*** Settings ***
Documentation    Setups for all applications: WinAppDriver, WinSetup, WinOpi
Library    ApplicationLibrary.DesktopLibrary
Library    OperatingSystem
#Library    Telnet





*** Variables ***
${REMOTE_URL}    http://10.70.49.139:4723/wd/hub
${Notepad}     C:/Windows/System32/notepad.exe
${stmAdmin}    C:/Rosemount/TankMaster/Server/StmAdministrator.exe
${winSetup}    C:/Rosemount/TankMaster/Setup/StmSetup.exe
${username_admin}    administrator
${username_supervisor}    supervisor
&{2460_A}         DeviceType=2460 System Hub    Tag=SYSHUB-201    CommunicationChanel=ModbusMaster.1    ModbusAddress=201    IndividualMBAddress=241    DeviceID=2100000712    SWVer=1.M0    IP_eth1=192.168.1.201    WebAdminUser=Administrator    WebAdminPass=admin    # 2460_A Device properties

&{Keys}           NULL=\ue000    CANCEL=\ue001    HELP=\ue002    BACKSPACE=\ue003    BACK_SPACE=\ue003    TAB=\ue004    CLEAR=\ue005    RETURN=\ue006    ENTER=\ue007    SHIFT=\ue008    LEFT_SHIFT=\ue008    CONTROL=\ue009    LEFT_CONTROL=\ue009    ALT=\ue00a    LEFT_ALT=\ue00a    PAUSE=\ue00b    ESCAPE=\ue00c
...               SPACE=\ue00d    PAGE_UP=\ue00e    PAGE_DOWN=\ue00f    END=\ue010    HOME=\ue011    LEFT=\ue012    ARROW_LEFT=\ue012    UP=\ue013    ARROW_UP=\ue013    RIGHT=\ue014    ARROW_RIGHT=\ue014    DOWN=\ue015    ARROW_DOWN=\ue015    INSERT=\ue016    DELETE=\ue017    SEMICOLON=\ue018    EQUALS=\ue019
...               NUMPAD0=\ue01a    NUMPAD1=\ue01b    NUMPAD2=\ue01c    NUMPAD3=\ue01d    NUMPAD4=\ue01e    NUMPAD5=\ue01f    NUMPAD6=\ue020    NUMPAD7=\ue021    NUMPAD8=\ue022    NUMPAD9=\ue023    MULTIPLY=\ue024    ADD=\ue025    SEPARATOR=\ue026    SUBTRACT=\ue027    DECIMAL=\ue028    DIVIDE=\ue029    F1=\ue031
...               F2=\ue032    F3=\ue033    F4=\ue034    F5=\ue035    F6=\ue036    F7=\ue037    F8=\ue038    F9=\ue039    F10=\ue03a    F11=\ue03b    F12=\ue03c    META=\ue03d    COMMAND=\ue03d    # Keyboard keys for selenium Send Key

*** Keywords ***
Start App
    [Documentation]    Sets up the application for quick launching through 'Launch Application' and starts the winappdriver
    ...    Note that the winappdriver must be launched before the test eithe manually or through a script on the target machine
    #Driver Setup    
    Open Application    ${REMOTE_URL}    platformName=Windows    deviceName=Windows    app=${Notepad}    alias=Main
    Maximize Window
    Sleep    1
    Quit Application


Close App
    Close Application

Run command    
    [Arguments]    ${command}         #command to run in the run dialog
    Run    ${command}    
    
    Comment    ${command}
    Send Keys    ${command}
    Send Keys    \ue007
    Sleep    1s


    
    
    