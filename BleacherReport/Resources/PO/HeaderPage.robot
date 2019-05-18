*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${HEADER_TEXT_XPATH} =  //nav[contains(@id, 'league-links')]//a

*** Keywords ***
Verify Header Parent
    [Arguments]  ${parent_text}
    element should be visible  ${parent_text}
    mouse over  ${parent_text}
    sleep  3

Verify Header Categories
    ${header_count} =  get element text  xpath:${HEADER_TEXT_XPATH}

    : FOR  ${index}  IN RANGE  1  ${header_count}
    \   element should be visible  xpath=(${HEADER_TEXT_XPATH})[${index}]
    \   ${text} =  get text  xpath=(${HEADER_TEXT_XPATH})[${index}]
    \   should not be empty  ${text}
    \   Verify Header Parent  xpath=(${HEADER_TEXT_XPATH})[${index}]

Click Log Out
    click element  xpath://li[contains(@class, 'userMenu')]//*[text()[contains(., 'Logout')]]

Click Home Logo
    click element  id:br-logo