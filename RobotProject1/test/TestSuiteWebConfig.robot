*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Run keywords
...               Log                                                         Inside Test Suite Setup
...               AND                                                         SetupChromedriver
Suite Teardown    Log                                                         Inside Test Suite Teardown

Test Setup        Log                                                         Inside Test Setup
Test Teardown     Log                                                         Inside Test Teardown

Default Tags      Haupttests

*** Variables ***
${PAGE_TITLE}     IPS 408i - webConfig © by Leuze electronic GmbH & Co. KG

*** Test Cases ***
FirstSeleniumTest
    SeleniumLibrary.Open Browser                     http://192.168.60.101                       Chrome
    SeleniumLibrary.Set Browser Implicit Wait        5
    SeleniumLibrary.Wait For Condition               return CoreApp.getInstance().isReady()
    SeleniumLibrary.Title Should Be                  ${PAGE_TITLE}
    Sleep                                            2
    SwitchToMode                                     service
    Sleep                                            5
    SwitchToMode                                     process
    Sleep                                            5
    SeleniumLibrary.Close Browser
    Log                                              Test Completed

*** Keywords ****
SetupChromedriver
    Set Environment Variable                         PATH                                        E:/Git_Projects/RobotFramework
SwitchToMode
    [Arguments]                                      ${expected}
    Sleep                                            2
    SeleniumLibrary.Wait Until Element Is Visible    id:mode_main_panel
    ${style}=                                        Get Element Attribute                       id:mode_main_panel                class
    Log                                              ${style}
    Should Not Contain                               ${style}                                    'disabled'
    ${passed}=                                       Run Keyword And Return Status               Should Not Contain                ${style}    ${expected}
    run keyword if                                   ${passed}                                   ChangeMode
ChangeMode
    SeleniumLibrary.Click Element At Coordinates     id:mode_main_panel                          0                                 0
    Sleep                                            5
    SeleniumLibrary.Element Should Be Visible        id:CoreUI_Window_ChangeModeConfirmDialog
    Sleep                                            2
    SeleniumLibrary.Click Element                    id:ChangeModeConfirmDialog_yesBtn