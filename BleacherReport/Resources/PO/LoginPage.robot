*** Settings ***
Library  SeleniumLibrary

*** Variables ***

*** Keywords ***
Verify Page Load
    wait until keyword succeeds  2 min  5 sec  wait until element is visible  class:chooseLoginMethod

Click on Email Login
    click button  Sign in with Email

Enter Email
    [Arguments]  ${email}
    input text  name:email  ${email}

Enter Password
    [Arguments]  ${password}
    input password  name:password  ${password}

Submit Credentials
    click button  Sign In
    sleep  3