*** Settings ***
Resource  ../Resources/Common.robot
Resource  ../Resources/BleacherReport.robot
Suite Setup  Insert Tag Data
Test Setup  Begin Web Test
Test Teardown  End Web Test
Suite Teardown  Clean Test Data

*** Variables ***
${START_URL} =          https://bleacherreport.com/
${BROWSER} =            Chrome
${TEST_EMAIL} =         TestEmail
${TEST_PASSWORD} =      Test1234!

*** Test Cases ***
Verify the user can log in via email
    [Documentation]  Verify that the user can successfully log into the application via a email address.
    [Tags]  Smoke
    BleacherReport.Load Home Page
    BleacherReport.Initiate Login Via Email  ${TEST_EMAIL}  ${TEST_PASSWORD}
    BleacherReport.Verify User is Logged In  Trevor

Verify the user can log out of an account
    [Documentation]  Verify that after the user has logged into a valid account, the can successfully log out of one.
    [Tags]  Smoke
    BleacherReport.Load Home Page
    BleacherReport.Initiate Login Via Email  ${TEST_EMAIL}  ${TEST_PASSWORD}
    BleacherReport.Log Out  Trevor
    BleacherReport.Verify User is Logged Out

Verify Featured Articles
    [Documentation]  Verify that the feature articles carousel properly loads content onto the page, that every element is present and that the each article header is not empty.
    [Tags]  Smoke
    BleacherReport.Load Home Page
    BleacherReport.Verify Featured Articles

Verify the user can add and remove teams
    [Documentation]  Verify that a logged in user can add and remove teams from their preferred teams.
    [Tags]  Smoke
    BleacherReport.Load Home Page
    BleacherReport.Initiate Login Via Email  ${TEST_EMAIL}  ${TEST_PASSWORD}
    BleacherReport.Locate My Teams
    BleacherReport.Verify My Team  Preds
    BleacherReport.Add and Verify My Team  Dodgers  Los Angeles Dodgers
    BleacherReport.Remove and Verify My Team Isnt Present  Dodgers