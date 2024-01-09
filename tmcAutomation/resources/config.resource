*** Settings ***
Documentation    Common variables across all applications: WinAppDriver, WinSetup, WinOpi and System administrator


*** Variables ***
${REMOTE_URL}    http://10.70.49.139:4723/wd/hub
${Notepad}       C:/Windows/System32/notepad.exe
${stmAdmin}      C:/Rosemount/TankMaster/Server/StmAdministrator.exe
${winSetup}      C:/Rosemount/TankMaster/Setup/StmSetup.exe
${winOpi}        C:/Rosemount/TankMaster/Opi/StmOpi.exe
&{2460_A}         DeviceType=2460 System Hub    Tag=SYSHUB-211    CommunicationChanel=ModbusMaster.1    ModbusAddress=201    IndividualMBAddress=241    DeviceID=1800000651    SWVer=1.M0    IP_eth1=10.70.49.119    WebAdminUser=Administrator    WebAdminPass=admin    # 2460_A Device properties
&{2410_A}         DeviceType=2410 Tank Hub    Tag=HUB-110    CommunicationChanel=ModbusMaster.1    ModbusAddress=110    DeviceID=30439    SWVer=1.H3    # 2410_1 Device properties
&{2410_B}         DeviceType=2410 Tank Hub    Tag=HUB-120    CommunicationChanel=ModbusMaster.1    ModbusAddress=120    DeviceID=30440    SWVer=1.H3    # 2410_1 Device properties
&{ATD_TK_1}       DeviceType=22XX Auxiliary Devices( 2230, 2240, ... )    Tag=ATD-TK-1    CommunicationChanel=ModbusMaster.1    ModbusAddress=110    2410_DeviceID=30439    SWVer=1.H3    # Auxiliary Device ATD-TK-1 properties
&{ATD-TK-2}       DeviceType=22XX Auxiliary Devices( 2230, 2240, ... )    Tag=ATD-TK-2    CommunicationChanel=ModbusMaster.1    ModbusAddress=120    2410_DeviceID=30440    SWVer=1.H3    # Auxiliary Device ATD-TK-1 properties
&{LT_TK_1}        DeviceType=5900S Radar Level Gauge    Tag=LT-TK-1    CommunicationChanel=ModbusMaster.1    ModbusAddress=111    DeviceID=2221        # 5900S LT-TK-1 properties
&{LT-TK-2}        DeviceType=5900S Radar Level Gauge    Tag=LT-TK-2    CommunicationChanel=ModbusMaster.1    ModbusAddress=121    DeviceID=2161        # 5900S LT-TK-2 properties
&{TK}             Tag=TK-1
&{Keys}           NULL=\ue000    CANCEL=\ue001    HELP=\ue002    BACKSPACE=\ue003    BACK_SPACE=\ue003    TAB=\ue004    CLEAR=\ue005    RETURN=\ue006    ENTER=\ue007    SHIFT=\ue008    LEFT_SHIFT=\ue008    CONTROL=\ue009    LEFT_CONTROL=\ue009    ALT=\ue00a    LEFT_ALT=\ue00a    PAUSE=\ue00b    ESCAPE=\ue00c
...               SPACE=\ue00d    PAGE_UP=\ue00e    PAGE_DOWN=\ue00f    END=\ue010    HOME=\ue011    LEFT=\ue012    ARROW_LEFT=\ue012    UP=\ue013    ARROW_UP=\ue013    RIGHT=\ue014    ARROW_RIGHT=\ue014    DOWN=\ue015    ARROW_DOWN=\ue015    INSERT=\ue016    DELETE=\ue017    SEMICOLON=\ue018    EQUALS=\ue019
...               NUMPAD0=\ue01a    NUMPAD1=\ue01b    NUMPAD2=\ue01c    NUMPAD3=\ue01d    NUMPAD4=\ue01e    NUMPAD5=\ue01f    NUMPAD6=\ue020    NUMPAD7=\ue021    NUMPAD8=\ue022    NUMPAD9=\ue023    MULTIPLY=\ue024    ADD=\ue025    SEPARATOR=\ue026    SUBTRACT=\ue027    DECIMAL=\ue028    DIVIDE=\ue029    F1=\ue031
...               F2=\ue032    F3=\ue033    F4=\ue034    F5=\ue035    F6=\ue036    F7=\ue037    F8=\ue038    F9=\ue039    F10=\ue03a    F11=\ue03b    F12=\ue03c    META=\ue03d    COMMAND=\ue03d    # Keyboard keys for selenium Send Key