*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

*** Keywords ***
Insert Tag Data
    log  I am setting up the test data...
    set environment variable  webdriver.chrome.driver  ${EXEC_DIR}\\Resources\\Drivers\\chromedriver.exe

Begin Web Test
    open browser  about:blank  ${BROWSER}
    Maximize Browser Window

End Web Test
    close browser

Clean Test Data
    log  I am cleaning up the test data...

Scroll to Element
    [Arguments]  ${x_location}  ${y_location}
    Execute Javascript  window.scrollTo(${x_location},${y_location})

Mouse Over Element
    [Arguments]  ${element_name}
    element should be visible  ${element_name}
    mouse over  ${element_name}
    sleep  1