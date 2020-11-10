*** Settings ***
Library           SeleniumLibrary   run_on_failure=Nothing

*** Variables ***
${URL}            https://www.saucedemo.com/
${BROWSER}        Chrome
${DRIVER}         chromedriver.exe
${DELAY}          0

*** Test Cases ***
Test Checkout
    Prepare Browser
    Login   standard_user   secret_sauce

    Add Item To Cart    Backpack

    Wait Until Page Contains Element    xpath=//div[@class='shopping_cart_container']
    Click Button    xpath=//div[@class='shopping_cart_container']

    Click Button    CHECKOUT

    #Close Browser

*** Keywords ***
Prepare Browser
    Open Browser    ${URL}    ${BROWSER}   executable_path=${DRIVER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Login
    [Arguments]     ${user}     ${password}
    Input text      id=user-name    ${user} 
    Input text      id=password     ${password}
    Click Button    LOGIN

Add Item To cart
    [Arguments]     ${item}
    Click Button    xpath=//div[@class='inventory_item' and contains(.,'${item}')]//button[contains(.,'ADD')]
