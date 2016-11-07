*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  etender_service.py

*** Variables ***
${locator.auctionID}                                           id=tenderidua
${locator.title}                                               jquery=tender-subject-info>div.row:contains('Загальний опис процедури:')>:eq(1)>
${locator.description}                                         jquery=tender-subject-info>div.row:contains('Лот виставляється на торги:')>:eq(1)>
${locator.minimalStep.amount}                                  xpath=//div[@class = 'row']/div/p[text() = 'Мінімальний крок аукціону:']/parent::div/following-sibling::div/p
${locator.procuringEntity.name}                                jquery=customer-info>div.row:contains("Найменування:")>:eq(1)>
${locator.value.amount}                                        id=lotvalue_0
${locator.proposition.value.amount}                            xpath=//div/input[@ng-model='bid.value.amount']
${locator.button.updateBid}                                    xpath=//button[@click-and-block='updateBid(bid)']
${locator.button.registrationProposition}                      xpath=//div[@id='addBidDiv']//button[contains(@class, 'btn btn-success')][contains(text(), 'Реєстрація пропозиції')]
${locator.dgfID}                                               xpath=//div[@class = 'row']/div/p[text() = 'Номер лоту в ФГВ:']/parent::div/following-sibling::div/p  # на сторінці перегляду
${locator.tenderPeriod.endDate}                                xpath=//div[@class = 'row']/div/p[text() = 'Завершення прийому пропозицій:']/parent::div/following-sibling::div/p
${locator.auctionPeriod.startDate}                             xpath=//span[@ng-if='lot.auctionPeriod.startDate']
${locator_item_description}                                    xpath=//div[@class = 'row']/div/p[text() = 'Опис активу:']/parent::div/following-sibling::div/p  #id=x25
${locator.items[0].description}                                xpath=//div[@class = 'row']/div/p[text() = 'Опис активу:']/parent::div/following-sibling::div/p
${locator.items[0].deliveryDate.endDate}                       xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[14]
${locator.items[0].deliveryLocation.latitude}                  id=delivery_latitude0
${locator.items[0].deliveryLocation.longitude}                 id=delivery_longitude0
${locator.items[0].deliveryAddress.postalCode}                 id=delivery_postIndex_0
${locator.items[0].deliveryAddress.countryName}                id=delivery_country_0
${locator.items[0].deliveryAddress.region}                     id=delivery_region_0
${locator.items[0].deliveryAddress.locality}                   xpath=//div[@class='col-sm-8']//span[@ng-if='item.deliveryAddress.city.title']
${locator.items[0].deliveryAddress.streetAddress}              xpath=//div[@class='col-sm-8']//span[@ng-if='item.deliveryAddress.addressStr']
${locator.items[0].classification.scheme}                      xpath=//div[6]/div[2]/div/p
${locator.items[0].classification.id}                          id=item_classification0
${locator_item_classification.description}                     id=item_class_descr0
${locator_item_classification.scheme}                          xpath=//div[@ng-repeat='item in lot.items']//p[contains(text(),'Класифікатор')]
${locator.items[0].classification.description}                 id=item_class_descr0
${locator.items[0].additionalClassifications[0].scheme}        xpath=//div[6]/div[3]/div/p
${locator.items[0].additionalClassifications[0].id}            id=additionalClassification_id0
${locator.items[0].additionalClassifications[0].description}   id=additionalClassification_desc0
${locator.items[0].unit.code}                                  id=item_unit_symb0
${locator_item_unit.code}                                      id=item_unit_symb0
${locator.items[0].quantity}                                   id=item_quantity0
${locator.questions[0].title}                                  id=quest_title_0
${locator.questions[0].description}                            id=quest_descr_0
${locator.questions[0].date}                                   id=quest_date_0
${locator.questions[0].answer}                                 id=question_answer_0
${locator.value.currency}                                      xpath=//span[@id='lotvalue_0']/parent::p
${locator.value.valueAddedTaxIncluded}                         xpath=//span[@id='lotvalue_0']/following-sibling::i
${locator.items[0].unit.name}                                  id=item_unit_symb0
${locator.bids}                                                id=ParticipiantInfo_0
${locator.status}                                              xpath=//p[text() = 'Статус:']/parent::div/following-sibling::div/p
${huge_timeout_for_visibility}  300
${grid_page_text}                                              ProZorro.продажі
${locator.eligibilityCriteria}                                 xpath=//div[@class = 'row']/div/p[text() = 'Критерії прийнятності:']/parent::div/following-sibling::div/p
${locator.lot_items_unit}                                      id=itemsUnit0                    #Одиниця виміру
${locator_document_title}                                      xpath=//tender-documents//a[contains(text(),'XX_doc_id_XX')]
${locator_question_title}                                      xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]
${locator_question_description}                                xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]/ancestor::div[contains(@ng-repeat,'question in questions')]//span[contains(@id,'quest_descr_')]
${locator_question_answer}                                     xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]/ancestor::div[contains(@ng-repeat,'question in questions')]//pre[contains(@id,'question_answer_')]
${locator_dgfID}                                               id=dgfID  # на сторінці створення
${locator_start_auction_creation}                              xpath=//a[contains(@class, 'btn btn-info') and @data-target='#procedureType']  # на сторінці створення
${locator_block_overlay}                                       xpath=//div[@class='blockUI blockOverlay']
${locator_auction_search_field}                                xpath=//input[@type='text' and @placeholder='Пошук за номером аукціону']

*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  @{ARGUMENTS}
  [Documentation]  Відкрити браузер, створити об’єкт api wrapper, тощо
  Open Browser  ${USERS.users['${ARGUMENTS[0]}'].homepage}  ${USERS.users['${ARGUMENTS[0]}'].browser}  alias=${ARGUMENTS[0]}
  Set Window Size  @{USERS.users['${ARGUMENTS[0]}'].size}
  Set Window Position  @{USERS.users['${ARGUMENTS[0]}'].position}
  Run Keyword If  '${ARGUMENTS[0]}' != 'Etender_Viewer'  Login  ${ARGUMENTS[0]}


Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  ${tender_data}=  Run Keyword IF  '${username}' != 'Etender_Viewer'   adapt_data   ${tender_data}
  ...             ELSE  Set Variable  ${tender_data}
  Log  ${tender_data}
  [return]  ${tender_data}


Login
  [Arguments]  @{ARGUMENTS}
  Wait Until Page Contains Element   id=btnLogin        180
  Capture Page Screenshot
  Sleep   10
  Click Link                         id=btnLogin
  Capture Page Screenshot
  Sleep   10
  Wait Until Page Contains Element   id=inputUsername   180
  Input text                         id=inputUsername   ${USERS.users['${ARGUMENTS[0]}'].login}
  Wait Until Page Contains Element   id=inputPassword   180
  Input text                         id=inputPassword   ${USERS.users['${ARGUMENTS[0]}'].password}
  Wait Until Page Contains Element   id=btn_submit      180
  Click Button                       id=btn_submit
  Sleep   10
  Wait Until Keyword Succeeds  ${huge_timeout_for_visibility}  30  Подивитися список аукціонів  ${USERS.users['${ARGUMENTS[0]}'].homepage}

Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data
  ${items}=               Get From Dictionary     ${ARGUMENTS[1].data}               items
  ${title}=               Get From Dictionary     ${ARGUMENTS[1].data}               title
  ${description}=         Get From Dictionary     ${ARGUMENTS[1].data}               description
  ${budget}=              Get From Dictionary     ${ARGUMENTS[1].data.value}         amount
  ${budgetToStr}=         float_to_string_2f      ${budget}      # at least 2 fractional point precision, avoid rounding
  ${step_rate}=           Get From Dictionary     ${ARGUMENTS[1].data.minimalStep}   amount
  ${step_rateToStr}=      float_to_string_2f      ${step_rate}   # at least 2 fractional point precision, avoid rounding
  ${lotGuarantee}=        Get From Dictionary     ${ARGUMENTS[1].data.guarantee}     amount
  ${lotGuaranteeToStr}=   float_to_string_2f      ${lotGuarantee}   # at least 2 fractional point precision, avoid rounding
  ${dgfID}=               Get From Dictionary     ${ARGUMENTS[1].data}               dgfID
  ${items_description}=   Get From Dictionary     ${items[0]}                        description
  ${quantity}=            Get From Dictionary     ${items[0]}                        quantity
  ${cav}=                 Get From Dictionary     ${items[0].classification}         id
  ${unit}=                Get From Dictionary     ${items[0].unit}                   name
  ${latitude}=            Get From Dictionary     ${items[0].deliveryLocation}       latitude
  ${longitude}=           Get From Dictionary     ${items[0].deliveryLocation}       longitude
  ${postalCode}=          Get From Dictionary     ${items[0].deliveryAddress}        postalCode
  ${streetAddress}=       Get From Dictionary     ${items[0].deliveryAddress}        streetAddress
  ${deliveryDate}=        Get From Dictionary     ${items[0].deliveryDate}           endDate
  ${deliveryDate}=        convert_date_to_etender_format        ${deliveryDate}
  ${start_date}=          get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          date
  ${start_time}=          get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          time


  Selenium2Library.Switch Browser   ${ARGUMENTS[0]}
  Wait Until Element Is Visible      xpath=//a[contains(@class, 'btnProfile')]
  Click Element                      xpath=//a[contains(@class, 'btnProfile')]
  Wait Until Element Is Visible      xpath=//a[contains(@class, 'ng-binding')][./text()='Мої торги']
  Click Element                      xpath=//a[contains(@class, 'ng-binding')][./text()='Мої торги']
  Wait Until Keyword Succeeds  ${huge_timeout_for_visibility}  30  Run Keywords
  ...  Reload Page
  ...  AND  Wait Until Element Is Visible  ${locator_start_auction_creation}  20
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Click Element                      ${locator_start_auction_creation}
  Wait Until Element Is Visible      id=goToCreate
  Click Element                      id=goToCreate
  Wait Until Element Is Visible      id=title
  Input text                         id=title                                            ${title}
  Wait Until Element Is Visible      id=description
  Input text                         id=description                                      ${description}
  Wait Until Page Contains Element   xpath=//input[@id="auctionPeriod_startDate_day"]
  Input text                         xpath=//input[@id="auctionPeriod_startDate_day"]    ${start_date}
  Wait Until Page Contains Element   xpath=//input[@id="auctionPeriod_startDate_time"]
  Input text                         xpath=//input[@id="auctionPeriod_startDate_time"]   ${start_time}
  Wait Until Element Is Visible      id=lotValue_0
  Input text                         id=lotValue_0                                       ${budgetToStr}
  Wait Until Element Is Visible      xpath=(//*[@id='valueAddedTaxIncluded'])[2]
  Click Element                      xpath=(//*[@id='valueAddedTaxIncluded'])[2]
  Wait Until Element Is Visible      id=minimalStep_0
  Input text                         id=minimalStep_0                                    ${step_rateToStr}
  Wait Until Element Is Visible      name=lotGuarantee0
  Input text                         name=lotGuarantee0                                  ${lotGuaranteeToStr}
  Wait Until Element Is Visible      id=itemsDescription0
  Input text                         id=itemsDescription0                                ${items_description}
  Wait Until Element Is Visible      id=itemsQuantity0
  Input text                         id=itemsQuantity0                                   ${quantity}
  ${unit_etender}=                   convert_common_string_to_etender_string             ${unit}
  Select From List By Label          ${locator.lot_items_unit}                           ${unit_etender}
  Wait Until Element Is Visible      xpath=//input[starts-with(@ng-click, 'openClassificationModal')]
  Click Element                      xpath=//input[starts-with(@ng-click, 'openClassificationModal')]
  Wait Until Element Is Visible      xpath=//div[contains(@class, 'modal-content')]//input[@ng-model='searchstring']
  Input text                         xpath=//div[contains(@class, 'modal-content')]//input[@ng-model='searchstring']  ${cav}
  Wait Until Element Is Visible      xpath=//td[contains(., '${cav}')]
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Click Element                      xpath=//td[contains(., '${cav}')]
  Wait Until Element Is Visible      xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]
  Click Element                      xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]   # end choosing classification
  Run Keyword if                     '${mode}' == 'multi'   Додати багато предметів   items
  Wait Until Element Is Visible      ${locator_dgfID}
  Input text                         ${locator_dgfID}                                    ${dgfID}
  Wait Until Element Is Visible      id=CreateTenderE
  Click Element                      id=CreateTenderE
  Wait Until Page Contains           Закупівлю створено!
  Wait Until Keyword Succeeds        ${huge_timeout_for_visibility}  10  Дочекатися завершення обробки аукціона
  ${tender_UAid}=                    Get Text            ${locator.auctionID}
  Log                                ${tender_UAid}
  ${Ids}=                            Convert To String   ${tender_UAid}
  log to console                     ${Ids}
  Log                                ${Ids}
  Run keyword if                     '${mode}' == 'multi'   Set Multi Ids   ${ARGUMENTS[0]}   ${tender_UAid}
  [return]                           ${Ids}

Дочекатися завершення обробки аукціона
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Element Is Visible      ${locator.auctionID}      30
  ${tender_id}=                      Get Text                  ${locator.auctionID}
  Should Match Regexp                ${tender_id}              UA-EA-\\d{4}-\\d{2}-\\d{2}-\\d+

Завантажити документ
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  file
  ...      ${ARGUMENTS[2]} ==  tender_uaid
  Wait Until Element Is Visible  id=tend_doc_add
  Choose File     id=tend_doc_add     ${ARGUMENTS[1]}
  Sleep   4
  Capture Page Screenshot

Додати предмет
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  items
  ...      ${ARGUMENTS[1]} ==  ${INDEX}
  ${dkpp_desc}=     Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   description
  ${dkpp_id}=       Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   id
  Sleep  2
  Click Element                      xpath=(//input[starts-with(@ng-click, 'openAddClassificationModal')])[${ARGUMENTS[1]}+1]
  Wait Until Element Is Visible      xpath=//div[contains(@id,'addClassification')]
  Sleep  1
  Input text                         xpath=//div[contains(@class, 'modal fade ng-scope in')]//input[@ng-model='searchstring']    ${dkpp_desc}
  Wait Until Element Is Visible      xpath=//td[contains(., '${dkpp_id}')]
  Sleep  2
  Click Element                      xpath=//td[contains(., '${dkpp_id}')]
  Click Element                      xpath=//div[@id='addClassification']//button[starts-with(@ng-click, 'choose(')]
  Sleep  2


Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${TENDER_UAID}
  Wait Until Keyword Succeeds  5 x  60  Спробувати знайти тендер по ідентифікатору  ${username}  ${TENDER_UAID}

Спробувати знайти тендер по ідентифікатору
  [Arguments]  ${username}  ${TENDER_UAID}
  Wait Until Keyword Succeeds  5 x  60  Подивитися список аукціонів  ${USERS.users['${username}'].homepage}
  Wait Until Page Contains Element  ${locator_auction_search_field}  60
  Wait Until Element Is Visible     ${locator_auction_search_field}  60
  Input Text                        ${locator_auction_search_field}  ${TENDER_UAID}
  sleep  2
  Wait Until Page Does Not Contain  ${locator_block_overlay}
  ${locator_auction_in_grid}=  Set Variable  jquery=a[href^='#/tenderDetailes']:contains('${TENDER_UAID}')
  Wait Until Page Contains Element  ${locator_auction_in_grid}  60
  ${auction_link_within_platform}=  Get Element Attribute  ${locator_auction_in_grid}@href
  Log  ${auction_link_within_platform}
  Click Link  ${locator_auction_in_grid}
  Wait Until Page Does Not Contain  ${locator_block_overlay}
  ${location}=  Get Location
  Log  ${location}
  Wait Until Page Contains    ${TENDER_UAID}   60
  Run Keyword And Ignore Error  Wait Until Page Contains Element  ${locator.auctionID}
  Run Keyword And Ignore Error  Get Text  ${locator.auctionID}

Подивитися список аукціонів
  [Arguments]  ${url}
  ${not_logged_error_message}=  Set Variable  No user logged in!
  ${authorization_label}=  Set Variable  Авторизація
  Go To  ${url}
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  ${no_problems}=  Run Keyword And Return Status  Page Should Not Contain  ${not_logged_error_message}
  Run Keyword Unless  ${no_problems}  Log  У нас знову проблема із неавторизованим користувачем, команда розробки Е-тендер має її виправити  WARN
  Page Should Not Contain  ${not_logged_error_message}
  ${no_problems}=  Run Keyword And Return Status  Page Should Not Contain  ${authorization_label}
  Run Keyword Unless  ${no_problems}  Log  У нас знову проблема із неавторизованим користувачем, команда розробки Е-тендер має її виправити  WARN
  Page Should Not Contain  ${authorization_label}
  Wait Until Page Contains   ${grid_page_text}

Завантажити документ в ставку
  [Arguments]  @{ARGUMENTS}
  [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId
  Selenium2Library.Switch Browser     ${ARGUMENTS[0]}
  Reload Page
  sleep   4
  Wait Until Element Is Visible   id=addNewDocToExistingBid_0   5
  Choose File                 id=addNewDocToExistingBid_0          ${ARGUMENTS[1]}
  sleep  10


Змінити документ в ставці
  [Arguments]  @{ARGUMENTS}
  [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  tenderId
    ...    ${ARGUMENTS[2]} ==  amount
    ...    ${ARGUMENTS[3]} ==  amount.value
  Sleep    3
  Click Element     id=changeDoc_0
  Sleep    3
  Choose File       id=updateBidDoc_0     ${ARGUMENTS[1]}
  Sleep   2


Подати цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} ==  ${test_bid_data}
  ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}          amount
  ${amount}=    float_to_string_2f      ${amount}
  Sleep  60
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  sleep  15
  Wait Until Page Contains Element  xpath=//input[@name='amount0']          30
  Input text                        xpath=//input[@name='amount0']          ${amount}
  Wait Until Element Is Enabled     ${locator.button.registrationProposition}
  Click Element                     ${locator.button.registrationProposition}
  Wait Until Page Contains          Пропозицію додано!                      30
  Sleep                             5
  Click Element                     xpath=//button[@click-and-block='activateBid(bid)']
  Log                               Button 'Підтвердити ставку' was created for Autotesting only
  Wait Until Page Contains          Пропозицію підтверджено!                30


Змінити цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} ==  ${test_bid_data}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Execute JavaScript                window.IzvDataSave=window.confirm;
  Execute JavaScript                window.confirm = function(msg){return true;};
# TODO: In the future will rewrite Alert Confirm with Selenium + Python
  Sleep    5
  ${str_argument}=                  float to string           ${ARGUMENTS[3]}
  Input text                        ${locator.proposition.value.amount}           ${str_argument}
  Sleep    5
  Wait Until Element Is Visible     ${locator.button.updateBid}
  Click Element                     ${locator.button.updateBid}
  Wait Until Page Contains          Пропозицію змінено!                 30
  Sleep                             5
  Click Element                     xpath=//button[@click-and-block='updateBid(bid,true)']
  Log                               Button 'Підтвердити редаговану ставку' was created for Autotesting only
  Wait Until Page Contains          Пропозицію змінено!                 30
  Execute JavaScript                window.confirm = window.IzvDataSave;

Скасувати цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Element Is Visible  xpath=//button[contains(@class, 'btn-sm btn-danger')]  ${huge_timeout_for_visibility}
  Click Element               xpath=//button[contains(@class, 'btn-sm btn-danger')]
  Wait Until Page Does Not Contain  Скасувати${SPACE}пропозицію  ${huge_timeout_for_visibility}

Оновити сторінку з тендером
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}
  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  etender.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Reload Page

Задати питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} = question_data
  ${title}=        Get From Dictionary  ${ARGUMENTS[2].data}  title
  ${description}=  Get From Dictionary  ${ARGUMENTS[2].data}  description
  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Execute Javascript   window.scrollTo(0, document.body.scrollHeight)
  Wait Until Element Is Visible      xpath=//a[contains(@href,'#/addQuestion/')]  ${huge_timeout_for_visibility}
  Sleep  1
  Click Element                      xpath=//a[contains(@href,'#/addQuestion/')]
  Wait Until Element Is Visible      id=title  ${huge_timeout_for_visibility}
  Sleep  1
  Input text                         id=title                 ${title}
  Input text                         id=description           ${description}
  Click Element                      xpath=//button[@type='submit']
  Wait Until Page Does Not Contain   xpath=//button[@type='submit']  ${huge_timeout_for_visibility}

Відповісти на питання
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} = username
  ...      ${ARGUMENTS[1]} = ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} = 0
  ...      ${ARGUMENTS[3]} = answer_data
  ${answer}=     Get From Dictionary  ${ARGUMENTS[3].data}  answer
  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Element Is Visible      id=addAnswer_0  ${huge_timeout_for_visibility}
  Wait Until Element Is Enabled      id=addAnswer_0  ${huge_timeout_for_visibility}
  Click Element                      id=addAnswer_0
  Wait Until Element Is Visible      xpath=//*[@id="questionContainer"]/form/div/textarea  ${huge_timeout_for_visibility}
  Input text                         xpath=//*[@id="questionContainer"]/form/div/textarea            ${answer}
  Wait Until Element Is Enabled      xpath=//*[@id="questionContainer"]/form/div/span/button[1]  ${huge_timeout_for_visibility}
  Click Element                      xpath=//*[@id="questionContainer"]/form/div/span/button[1]
  Wait Until Element Is Not Visible  xpath=//*[@id="questionContainer"]/form/div/span/button[1]  ${huge_timeout_for_visibility}

Внести зміни в тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}
  Log  ${ARGUMENTS[0]}
  Log  ${ARGUMENTS[1]}
  ${description}=   Convert To String    новое описание тендера
  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Wait Until Page Contains Element   xpath=//a[@class='btn btn-primary ng-scope']   ${huge_timeout_for_visibility}
  Click Element              xpath=//a[@class='btn btn-primary ng-scope']
  Sleep  2
  Input text               id=description    ${description}
  Click Element            id=SaveChanges


Отримати інформацію із тендера
  [Arguments]  ${user}  ${tender_id}  ${fieldname}
  [Documentation]
  ...      Викликає кейворди для отримання відповідних полів. Неявно очікує що сторінка аукціона вже відкрита
  Switch browser   ${user}
  Run Keyword And Return  Отримати інформацію про ${fieldname}

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  Reload Page
  Wait Until Page Contains Element    ${locator.${fieldname}}  ${huge_timeout_for_visibility}
  Wait Until Keyword Succeeds  ${huge_timeout_for_visibility}  5  Check Is Element Loaded  ${locator.${fieldname}}
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [return]  ${return_value}

Check Is Element Loaded
  [Arguments]  ${locator}
  ${text_value}=   Get Text  ${locator}
  Log  ${text_value}
  Should Not Be Empty  ${text_value}
  Should Not Be Equal  ${text_value}  -

Отримати інформацію про title
  ${return_value}=   Отримати текст із поля і показати на сторінці   title
  [return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  @{pattern_to_remove}=   Create List  [^0-9 ,\.]+
  ${return_value}=   Remove String Using Regexp  ${return_value}  @{pattern_to_remove}
  ${return_value}=   Set Variable  ${return_value.replace(' ','')}
  ${return_value}=   Convert To Number   ${return_value.replace(',','.')}
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  [return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.amount
  ${return_value}=   Set Variable  ${return_value.replace(' ','')}
  ${return_value}=   Convert To Number   ${return_value.replace(',','.')}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryLocation.latitude
  ${return_value}=   string_to_float   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryLocation.longitude
  #${return_value}=   Convert To Number   ${return_value}
  ${return_value}=   string_to_float   ${return_value}
  [return]  ${return_value}

Отримати інформацію про value.currency
  ${return_value}=   Отримати текст із поля і показати на сторінці   value.currency
  @{pattern_to_remove}=   Create List  [0-9 ,\.]+
  ${return_value}=   Remove String Using Regexp  ${return_value}  @{pattern_to_remove}
  ${return_value}=   Set Variable  ${return_value.split('(')[0]}
  [return]  ${return_value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=   Отримати текст із поля і показати на сторінці   value.valueAddedTaxIncluded
  ${return_value}=  Run Keyword If  'ПДВ' in '${return_value}'  Set Variable  True
    ...  ELSE  Set Variable  False
  Log  ${return_value}
  ${return_value}=   Convert To Boolean   ${return_value}
  [return]  ${return_value}


Отримати інформацію про items[0].unit.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.name
  ${return_value}=   convert_etender_string_to_common_string   ${return_value}
  [return]  ${return_value}


Відмітити на сторінці поле з тендера
  [Arguments]   ${fieldname}  ${locator}
  ${last_note_id}=  Add pointy note   ${locator}   Found ${fieldname}   width=200  position=bottom
  Align elements horizontally    ${locator}   ${last_note_id}
  sleep  1
  Remove element   ${last_note_id}

Отримати інформацію про auctionID
  ${return_value}=   Отримати текст із поля і показати на сторінці   auctionID
  [return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.startDate
  log  це поле не актуальне для поточної версії аукціонів. Повертати значення потрібно лише для того, щоб не було помилки
  [return]  ${EMPTY}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  log  це поле не актуальне для поточної версії аукціонів. Повертати значення потрібно лише для того, щоб не було помилки
  [return]  ${EMPTY}

Отримати інформацію про enquiryPeriod.endDate
  log  це поле не актуальне для поточної версії аукціонів. Повертати значення потрібно лише для того, щоб не було помилки
  [return]  ${EMPTY}

Отримати інформацію про auctionPeriod.endDate
  ${return_value}=  Set Variable  Дане поле auctionPeriod.endDate не відображається на майданчику
  [return]  ${return_value}

Отримати інформацію про auctionPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  auctionPeriod.startDate
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
  ${return_value}=   add_timezone_to_date   ${return_value.split('.')[0]}
  [return]  ${return_value}

Change_date_to_month
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]}  ==  date
  ${day}=   Get Substring   ${ARGUMENTS[0]}   0   2
  ${month}=   Get Substring   ${ARGUMENTS[0]}  3   6
  ${year}=   Get Substring   ${ARGUMENTS[0]}   5
  ${return_value}=   Convert To String  ${month}${day}${year}
  [return]  ${return_value}

Отримати інформацію про items[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].description
  [return]  ${return_value}

Отримати інформацію про items[0].unit.code
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].unit.code
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  ${return_value}=   convert_unit_name_to_unit_code  ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].quantity
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].classification.id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.id
  [return]  ${return_value}

Отримати інформацію про items[0].classification.scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.scheme
  ${return_value}=   Get Substring  ${return_value}   0   -1
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про items[0].classification.description
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.description
  Run Keyword And Return  convert_etender_string_to_common_string  ${return_value}

Отримати інформацію про items[0].additionalClassifications[0].id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].id
  [return]  ${return_value.split(' ')[0]}

Отримати інформацію про items[0].additionalClassifications[0].scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].scheme
  ${return_value}=   Get Substring  ${return_value}   0   -1
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про items[0].additionalClassifications[0].description
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].description
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  Run Keyword And Return  Get Substring  ${return_value}  0  5

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.countryName
  Run Keyword And Return  Get Substring  ${return_value}  0  7

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.region
  ${return_value}=    convert_etender_string_to_common_string     ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.locality
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.locality
  ${return_value}=   Remove String      ${return_value}     ,
  ${return_value}=    convert_etender_string_to_common_string     ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.streetAddress
  Run Keyword And Return  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.streetAddress

Отримати інформацію про items[0].deliveryDate.endDate
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryDate.endDate
  ${time}=  Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${time}=  Get Substring  ${time}  11
  ${day}=  Get Substring  ${return_value}  16  18
  ${month}=  Get Substring  ${return_value}  18  22
  ${year}=  Get Substring  ${return_value}  22
  Run Keyword And Return  Convert To String  ${year}${month}${day}${time}

Отримати інформацію про questions[0].title
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].title
  Sleep   3
  ${return_value}=    Get text   id=quest_title_0
  [return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  Sleep   3
  ${return_value}=    Get text   id=quest_descr_0
  [return]  ${return_value}

Отримати інформацію про questions[0].date
  Sleep   3
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
  [return]  ${return_value}


Отримати інформацію про questions[0].answer
  Reload Page
  Wait Until Element Is Visible  ${locator.questions[0].answer}
  ${return_value}=     Отримати текст із поля і показати на сторінці     questions[0].answer
  Sleep   4
  ${return_value}=    Get text   xpath=//div[@textarea='question.answer']
  [return]  ${return_value}
  Capture Page Screenshot

Отримати інформацію про status
  ${status}=   Отримати текст із поля і показати на сторінці   status
  ${return_value}=   convert_etender_string_to_common_string      ${status}
  [return]    ${return_value}

Отримати інформацію про dgfID
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfID
  [return]    ${return_value}

Отримати інформацію про eligibilityCriteria
  ${return_value}=   Отримати текст із поля і показати на сторінці   eligibilityCriteria
  [return]    ${return_value}

Отримати посилання на аукціон для глядача
  [Arguments]  @{ARGUMENTS}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Sleep  60
  Page Should Contain Element  xpath=//a[@id='lot_auctionUrl_0']
  Sleep  3
  ${url}=  Get Element Attribute  xpath=//*[@id="lot_auctionUrl_0"]@href
  [return]  ${url}

Отримати посилання на аукціон для учасника
  [Arguments]  @{ARGUMENTS}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Sleep  60
  Page Should Contain Element  xpath=//a[@id='participationUrl_0']
  Sleep  3
  ${url}=  Get Element Attribute  xpath=//*[@id="participationUrl_0"]@href
  [return]  ${url}

Отримати інформацію із предмету
  [Arguments]    ${user}    ${tender_uaid}    ${item_id}    ${fieldname}
  Switch browser   ${user}
  ${prepared_locator}=  Set Variable  ${locator_item_${fieldname}}
  log  ${prepared_locator}
  Wait Until Page Contains Element  ${prepared_locator}  1
  ${raw_value}=   Get Text  ${prepared_locator}
  Run Keyword And Return  Конвертувати інформацію із предмету про ${fieldname}  ${raw_value}

Конвертувати інформацію із предмету про description
  [Arguments]  ${raw_value}
  Log  Тимчасове рішення для обробки неточних даних із двома пробілами - надалі неточні має виправити prozorro
  ${one_space}=  set variable  Житлова нерухомість
  ${two_spaces}=  set variable  Житлова\ \ нерухомість
  ${return_value}=  Set Variable  ${raw_value.replace(u'${one_space}', u'${two_spaces}')}
  [return]  ${return_value}

Конвертувати інформацію із предмету про unit.code
  [Arguments]  ${raw_value}
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  ${return_value}=  convert_unit_name_to_unit_code  ${raw_value}
  [return]  ${return_value}

Конвертувати інформацію із предмету про classification.description
  [Arguments]  ${raw_value}
  [return]  ${raw_value}

Конвертувати інформацію із предмету про classification.scheme
  [Arguments]  ${raw_value}
  ${return_value}=   Set Variable  ${raw_value.split(' ')[1]}
  ${return_value}=   Set Variable  ${return_value.split(':')[0]}
  [return]  ${return_value}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field}
  Switch browser   ${username}
  ${prepared_locator}=  Set Variable  ${locator_document_${field}.replace('XX_doc_id_XX','${doc_id}')}
  log  ${prepared_locator}
  Wait Until Page Contains Element  ${prepared_locator}  10
  ${raw_value}=   Get Text  ${prepared_locator}
  Run Keyword And Return  Конвертувати інформацію із документа про ${field}  ${raw_value}

Конвертувати інформацію із документа про title
  [Arguments]  ${raw_value}
  ${return_value}=  Set Variable  ${raw_value.split(',')[0]}
  [return]  ${return_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field}
  Switch browser   ${username}
  Reload Page
  ${prepared_locator}=  Set Variable  ${locator_question_${field}.replace('XX_que_id_XX','${question_id}')}
  log  ${prepared_locator}
  Wait Until Page Contains Element  ${prepared_locator}  10
  ${raw_value}=   Get Text  ${prepared_locator}
  Run Keyword And Return  Конвертувати інформацію із запитання про ${field}  ${raw_value}

Конвертувати інформацію із запитання про title
  [Arguments]  ${return_value}
  [return]  ${return_value}

Конвертувати інформацію із запитання про description
  [Arguments]  ${return_value}
  [return]  ${return_value}

Конвертувати інформацію із запитання про answer
  [Arguments]  ${return_value}
  [return]  ${return_value}

Отримати пропозицію
  [Arguments]  ${field}
  Wait Until Page Contains Element    ${locator.proposition.${field}}            60
  ${proposition_amount}=              Get Value                                  ${locator.proposition.${field}}
  ${proposition_amount}=              Convert To Number                          ${proposition_amount}
  log                                 ${proposition_amount}
  ${data}=     Create Dictionary
  ${bid}=      Create Dictionary
  ${value}=    Create Dictionary
  Set To Dictionary  ${bid}     data=${data}
  Set To Dictionary  ${data}    value=${value}
  Set To Dictionary  ${value}   amount=${proposition_amount}
  [return]           ${bid}

Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ${bid}=   etender.Отримати пропозицію  ${field}
  [return]  ${bid.data.${field}}


Підтвердити постачальника
  [Documentation]
  ...      [Arguments] Username, tender uaid and number of the award to confirm
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  sleep  5
  Capture Page Screenshot
  Click Element  xpath=//a[@data-target='#modalGetAwards']
  sleep  5
  Capture Page Screenshot
  Click Element  xpath=//button[@ng-click='getAwardsNextStep()']
  sleep  5
  Capture Page Screenshot
  Click Element  xpath=//button[@click-and-block='setDecision(1)']
  sleep  5
  Capture Page Screenshot

Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
  log  ${username}
  log  ${tender_uaid}
  log  ${contract_num}
  log  ${filepath}
  sleep  5
  Capture Page Screenshot
  Click Element  xpath=//a[text()='Контракт']
  sleep  5
  Capture Page Screenshot
  Choose File  xpath=//button[@ng-model='documentsToAdd']  ${filepath}
  Capture Page Screenshot
  sleep  1
  Capture Page Screenshot
  sleep  240  #  wait till disappears "Поки не експортовано"
  Capture Page Screenshot
  Reload Page
  Sleep  20
  Capture Page Screenshot
  ${href}=  Get Element Attribute  xpath=(//div[@ng-show='!document.isDeleted']/a)@href
  sleep  5
  Capture Page Screenshot
  sleep  20
  [return]  ${href}

Підтвердити підписання контракту
  [Documentation]
  ...      [Arguments] Username, tender uaid, contract number
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  sleep  10
  Capture Page Screenshot
  Click Element  xpath=//a[text()='Контракт']
  Capture Page Screenshot
  sleep  20
  ${contract_num_str}=  Convert To String  ${contract_num}
  Input text  id=contractNumber  ${contract_num_str}
  Capture Page Screenshot
  Click Element  xpath=//button[text()='Завершити аукціон']
  sleep  1
  Capture Page Screenshot
  sleep  20
  Capture Page Screenshot