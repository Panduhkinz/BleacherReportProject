*** Settings ***
Library  SeleniumLibrary
Resource  ../Common.robot

*** Variables ***
${TEAM_LOCATIONS} =  //div[contains(@class, 'myTeams')]//div[contains(@class, 'sortableElement')]

*** Keywords ***
Search Team Name
    [Arguments]  ${team_name}  ${long_team_name}
    input text  id:search-term  ${team_name}
    Common.Mouse Over Element  id:search-term
    click element  xpath://li[contains(@class, 'search-result')]//*[contains(text(), '${long_team_name}')]
    sleep  1

Initiate Edit My Teams
    click button  xpath://div[contains(@class, 'myTeams')]/button

Locate and Remove Team
    [Arguments]  ${team_name}
    ${count} =  get element count  xpath:(${TEAM_LOCATIONS})

    : FOR  ${index}  IN RANGE  1  ${count+1}
    \   ${current_name}  get element attribute  xpath:(${TEAM_LOCATIONS})[${index}]  innerText
    \   run keyword if  '${current_name}' == '${team_name}'  Click Close Icon  ${index}

    Save Team Edit

Click Close Icon
    [Arguments]  ${index}
    click element  xpath=(${TEAM_LOCATIONS})[${index}]/*[local-name() = 'svg']

Save Team Edit
    click button  xpath://span[contains(@class, 'editActions')]/button[contains(@class, 'save')]