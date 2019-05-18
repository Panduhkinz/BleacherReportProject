*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  String
Library  Collections
Resource  ../Common.robot

*** Variables ***
${ARTICLES_TEXT_XPATH} =        //*[contains(@class, 'featuredArticles')]//a[contains(@class, 'articleTitle')]/h3
${ARTICLES_IMG_PARENT_XPATH} =  //*[contains(@class, 'featuredArticles')]//*[contains(@class, 'articleMedia')]
${ARTICLES_IMG_XPATH} =         //*[contains(@class, 'featuredArticles')]//*[contains(@class, 'articleMedia')]//img
@{MY_TEAMS_NAMES}

*** Keywords ***
Load
    go to  ${START_URL}

Dismiss Privacy Notice
    ${present} =  get element count  xpath://*[contains(@class, 'privacy_notice')]
    run keyword if  ${present} > 0  click button  xpath://*[contains(@class, 'privacy_notice')]//button

Click on Login
    wait until keyword succeeds  2 min  5 sec  click element  xpath://*[@id="app"]/div/header/div/div/ul/li[2]/a

Verify Username
    [Arguments]  ${username}
    element text should be  class:userMenu  ${username}

Verify Login Is Present
    wait until element contains  xpath://ul[contains(@class, 'userTools')]//a[contains(@class, 'login')]  Login

Verify Featured Articles Header
    ${count} =  get element count  xpath:${ARTICLES_TEXT_XPATH}

    : FOR  ${index}  IN RANGE  1  ${count}
    \   ${text} =  get text  xpath=(${ARTICLES_TEXT_XPATH})[${index}]
    \   should not be empty  ${text}

Verify Featured Articles Images
    ${count} =  get element count  xpath:${ARTICLES_TEXT_XPATH}

    : FOR  ${index}  IN RANGE  1  ${count}
    \   ${x_index} =  get horizontal position  xpath=(${ARTICLES_IMG_XPATH})[${index}]
    \   ${y_index} =  get vertical position  xpath=(${ARTICLES_IMG_XPATH})[${index}]
    \   Common.Scroll to Element  ${x_index}  ${y_index}
    \   ${img_inner_html} =  get element attribute  xpath=(${ARTICLES_IMG_PARENT_XPATH})[${index}]  innerHTML
    \   ${contains} =  EVALUATE  "video" not in """${img_inner_html}"""
    \   run keyword if  ${contains}  Verify Image Has Loaded  ${index}

Verify Image Has Loaded
    [Arguments]  ${index}
    element should be visible  xpath=(${ARTICLES_IMG_XPATH})[${index}]
    ${img_src} =  get element attribute  xpath=(${ARTICLES_IMG_XPATH})[${index}]  src
    Create Session  img-src  ${img_src}
    ${response}  get request  img-src  /
    should be equal as integers  ${response.status_code}  200

Verify My Team Appears In List
    [Arguments]  ${team_name}
    ${count} =  get element count  xpath://div[contains(@class, 'teamAvatarWrapper')]/div

    : FOR  ${index}  IN RANGE  1  ${count+1}
    \   ${current_name}  get text  xpath://div[contains(@class, 'teamAvatarWrapper')]/div[${index}]/span
    \   append to list  ${MY_TEAMS_NAMES}  ${current_name}

    ${contains}  set variable  False

    : FOR  ${name}  IN  @{MY_TEAMS_NAMES}
    \   ${contains} =  EVALUATE  """${team_name}""" in """${name}"""
    \   run keyword if  ${contains} == True  exit for loop

    @{MY_TEAMS_NAMES}  create list

    run keyword if  ${contains} == False  fail

Verify My Team Does Not Appear In List
    [Arguments]  ${team_name}
    ${count} =  get element count  xpath://div[contains(@class, 'teamAvatarWrapper')]/div

    @{MY_TEAMS_NAMES}  create list

    : FOR  ${index}  IN RANGE  1  ${count+1}
    \   ${current_name}  get text  xpath://div[contains(@class, 'teamAvatarWrapper')]/div[${index}]/span
    \   append to list  ${MY_TEAMS_NAMES}  ${current_name}

    ${contains}  set variable  False

    : FOR  ${name}  IN  @{MY_TEAMS_NAMES}
    \   ${contains} =  EVALUATE  """${team_name}""" in """${name}"""
    \   run keyword if  ${contains} == True  exit for loop

    run keyword if  ${contains} == True  fail  Team was not removed

Initiate Edit My Teams
    click element at coordinates  class:editTeams  0  0
    sleep  1