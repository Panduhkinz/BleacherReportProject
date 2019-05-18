*** Settings ***
Resource  ./PO/HomePage.robot
Resource  ./PO/LoginPage.robot
Resource  ./PO/HeaderPage.robot
Resource  ./PO/MyTeamsPage.robot

*** Keywords ***
Load Home Page
    HomePage.Load
    HomePage.Dismiss Privacy Notice

Initiate Login Via Email
    [Arguments]  ${email}  ${password}
    HomePage.Click on Login
    LoginPage.Verify Page Load
    LoginPage.Click on Email Login
    LoginPage.Enter Email  ${email}
    LoginPage.Enter Password  ${password}
    LoginPage.Submit Credentials

Verify User is Logged In
    [Arguments]  ${username}
    HomePage.Verify Username  ${username}

Verify User is Logged Out
    HomePage.Verify Login Is Present

Log Out
    [Arguments]  ${username}
    Common.Mouse Over Element  xpath://li[contains(@class, 'userMenu') and contains(text(), '${username}')]
    HeaderPage.Click Log Out

Verify Featured Articles
    HomePage.Verify Featured Articles Header
    HomePage.Verify Featured Articles Images

Locate My Teams
    ${x_index} =  get horizontal position  class:teamStreamList
    ${y_index} =  get vertical position  class:teamStreamList
    Common.Scroll to Element  ${x_index}  ${y_index}

Add and Verify My Team
    [Arguments]  ${team_name}  ${long_team_name}
    HomePage.Initiate Edit My Teams
    MyTeamsPage.Search Team Name  ${team_name}  ${long_team_name}
    HeaderPage.Click Home Logo
    HomePage.Verify My Team Appears In List  ${team_name}

Verify My Team
    [Arguments]  ${team_name}
    HomePage.Verify My Team Appears In List  ${team_name}

Remove and Verify My Team Isnt Present
    [Arguments]  ${team_name}
    HomePage.Initiate Edit My Teams
    MyTeamsPage.Initiate Edit My Teams
    MyTeamsPage.Locate and Remove Team  ${team_name}
    HeaderPage.Click Home Logo
    HomePage.Verify My Team Does Not Appear In List  ${team_name}