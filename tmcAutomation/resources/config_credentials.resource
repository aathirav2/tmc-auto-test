*** Settings ***
Documentation   Credentials across all applications: WinAppDriver, WinSetup, WinOpi and System administrator
Library    ApplicationLibrary.DesktopLibrary


*** Variables ***
${username_admin}    administrator
${password_admin}    <ADMIN_PASSWORD>
${username_supervisor}    supervisor
${password_supervisor}    <SUPER_PASSWORD>