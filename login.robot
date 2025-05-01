*** Settings ***
Documentation     Test case cho trang login OrangeHRM
Library           SeleniumLibrary

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USERNAME}    Admin
${VALID_PASSWORD}    admin123
${INVALID_USERNAME}  Adminfake
${INVALID_PASSWORD}  admin12345

*** Test Cases ***
Đăng nhập thành công
    Mở trình duyệt
    Đăng nhập    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Kiểm tra đăng nhập thành công
    Đóng trình duyệt

Đăng nhập thất bại
    Mở trình duyệt
    Đăng nhập    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Kiểm tra đăng nhập thất bại
    Đóng trình duyệt

*** Keywords ***
Mở trình duyệt
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    name=username    timeout=10s

Đăng nhập
    [Arguments]    ${username}    ${password}
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    css=button[type='submit']

Kiểm tra đăng nhập thành công
    Wait Until Element Is Visible    css=.oxd-topbar-header-title    timeout=10s
    Element Should Be Visible    css=.oxd-topbar-header-title
    Location Should Contain    dashboard

Kiểm tra đăng nhập thất bại
    Wait Until Element Is Visible    css=.oxd-alert-content-text    timeout=10s
    Element Should Contain    css=.oxd-alert-content-text    Invalid credentials

Đóng trình duyệt
    Close Browser