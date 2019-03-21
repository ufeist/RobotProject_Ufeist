*** Settings ***
Library    SeleniumLibrary    
  
Suite Setup       Log    Inside Test Suite Setup
Suite Teardown    Log    Inside Test Suite Teardown

Test Setup        Log    Inside Test Setup
Test Teardown     Log    Inside Test Teardown                

Default Tags    Haupttests
 

*** Test Cases ***
MyFirstTest
    Log    First Test
    
MySecondTest
    [Tags]    smoke
    Log    Second Test 
    
MyThirdTest
    Log    Third Test      
    Set Tags    regression1 
    #Remove Tags    regression1  
    
FirstSeleniumTest
    #Create Webdriver    Chrome    executable_path=chromedriver.exe
    #Go To    https://google.com
    Open Browser                https://google.com    chrome
    Set Browser Implicit Wait   5
    Input Text                  name=q                Test
    Sleep                       1
    Press Keys                  name=q                ENTER
    Sleep                       2    
    Close Browser
    Log                         Test Completed
 

SampleLoginTest
    [Documentation]  This is a sample login test
    Open Browser                ${URL}                chrome 
    Set Browser Implicit Wait   5
    LoginKW
    #Input Text                  id=txtUsername        @{CREDENTIALS}[0]
    #Input Password              id=txtPassword        &{LOGINDATA}[password]
    #Click Button                id=btnLogin   
    Click Element               id=welcome         
    Click Element               link=Logout
    Sleep                       2 
    Close Browser
    Log                         Test Completed
    Log                         This test was executed by %{username} on %{os}  #Umgebungsvariablen
    
    
*** Variables ***
${URL}                          https://opensource-demo.orangehrmlive.com/  #einfache Variable
@{CREDENTIALS}                  Admin                 admin123              #Felder / Listen    
&{LOGINDATA}                    username=Admin        password=admin123     #Strukturen


*** Keywords ***
LoginKW   #User Keyword
    Input Text                  id=txtUsername        @{CREDENTIALS}[0]
    Input Password              id=txtPassword        &{LOGINDATA}[password]
    Click Button                id=btnLogin      
    