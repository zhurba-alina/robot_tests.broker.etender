*** Settings ***
Library  Selenium2Screenshots
Library  String
Library  DateTime
Library  etender_service.py

*** Variables ***
${locator.auctionID}                                           id=tenderidua
${locator.title}                                               jquery=tender-subject-info>div.row:contains('Назва аукціону:')>:eq(1)>
${locator.description}                                         jquery=tender-subject-info>div.row:contains('Детальний опис аукціону:')>:eq(1)>
${locator.minimalStep.amount}                                  xpath=//div[@class = 'row']/div/p[text() = 'Мінімальний крок аукціону:']/parent::div/following-sibling::div/p
${locator.procuringEntity.name}                                jquery=customer-info>div.row:contains("Найменування:")>:eq(1)>
${locator.value.amount}                                        id=totalvalue
${locator.tenderPeriod.startDate}                              xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[3]
${locator.tenderPeriod.endDate}                                xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[4]
${locator.enquiryPeriod.startDate}                             xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[1]
${locator.enquiryPeriod.endDate}                               xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[2]
${locator.items[0].description}                                jquery=tender-subject-info * div.row:contains('Конкретна назва предмету аукціону:')>:eq(1)>
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
${locator.items[0].classification.description}                 id=item_class_descr0
${locator.items[0].additionalClassifications[0].scheme}        xpath=//div[6]/div[3]/div/p
${locator.items[0].additionalClassifications[0].id}            id=additionalClassification_id0
${locator.items[0].additionalClassifications[0].description}   id=additionalClassification_desc0
${locator.items[0].unit.code}                                  id=item_unit_symb0
${locator.items[0].quantity}                                   id=item_quantity0
${locator.questions[0].title}                                  id=quest_title_0
${locator.questions[0].description}                            id=quest_descr_0
${locator.questions[0].date}                                   id=quest_date_0
${locator.questions[0].answer}                                 id=question_answer_0
${locator.value.currency}                                      xpath=//div[@class = 'row']/div/p[text() = 'Повний доступний бюджет закупівлі:']/parent::div/following-sibling::div/p/span[2]
${locator.value.valueAddedTaxIncluded}                         xpath=//div[2]/p/i
${locator.items[0].unit.name}                                  id=item_unit_symb0
${locator.bids}                                                id=ParticipiantInfo_0
${locator.status}                                              xpath=//div[@class = 'row']/div/p[text() = 'Статус:']/parent::div/following-sibling::div/p


*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  @{ARGUMENTS}
  [Documentation]  Відкрити браузер, створити об’єкт api wrapper, тощо
  Open Browser  ${USERS.users['${ARGUMENTS[0]}'].homepage}  ${USERS.users['${ARGUMENTS[0]}'].browser}  alias=${ARGUMENTS[0]}
  Set Window Size  @{USERS.users['${ARGUMENTS[0]}'].size}
  Set Window Position  @{USERS.users['${ARGUMENTS[0]}'].position}
  Run Keyword If  '${ARGUMENTS[0]}' != 'Etender_Viewer'  Login  ${ARGUMENTS[0]}


Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}
  ${tender_data}=  change_data  ${tender_data}
  Log  ${tender_data}
  [return]  ${tender_data}


Login
  [Arguments]  @{ARGUMENTS}
  Wait Until Page Contains Element   jquery=a[href^="#/login"]    10
  Sleep    1
  Click Link    jquery=a[href^="#/login"]
  Sleep    1
  Wait Until Page Contains Element   id=inputUsername   180
  Sleep  1
  Input text   id=inputUsername      ${USERS.users['${ARGUMENTS[0]}'].login}
  Wait Until Page Contains Element   id=inputPassword   180
  Sleep  1
  Input text   id=inputPassword      ${USERS.users['${ARGUMENTS[0]}'].password}
  Click Button   id=btn_submit
  Go To  ${USERS.users['${ARGUMENTS[0]}'].homepage}

Створити тендер
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  tender_data
  ${items}=             Get From Dictionary     ${ARGUMENTS[1].data}               items
  ${title}=             Get From Dictionary     ${ARGUMENTS[1].data}               title
  ${description}=       Get From Dictionary     ${ARGUMENTS[1].data}               description
  ${budget}=            Get From Dictionary     ${ARGUMENTS[1].data.value}         amount
  ${step_rate}=         Get From Dictionary     ${ARGUMENTS[1].data.minimalStep}   amount
  ${items_description}=   Get From Dictionary   ${items[0]}         description
  ${quantity}=          Get From Dictionary     ${items[0]}                        quantity
  ${cpv}=               Get From Dictionary     ${items[0].classification}         id
  ${unit}=              Get From Dictionary     ${items[0].unit}                   name
  ${latitude}=          Get From Dictionary     ${items[0].deliveryLocation}      latitude
  ${longitude}=         Get From Dictionary     ${items[0].deliveryLocation}      longitude
  ${postalCode}=        Get From Dictionary     ${items[0].deliveryAddress}       postalCode
  ${streetAddress}=     Get From Dictionary     ${items[0].deliveryAddress}       streetAddress
  ${deliveryDate}=      Get From Dictionary     ${items[0].deliveryDate}          endDate
  ${deliveryDate}=      convert_date_to_etender_format        ${deliveryDate}
  ${enquiry_end_date}=   get_all_etender_dates   ${ARGUMENTS[1]}         EndPeriod          date
  ${enquiry_end_time}=   get_all_etender_dates   ${ARGUMENTS[1]}         EndPeriod          time
  ${start_date}=         get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          date
  ${start_time}=         get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          time
  ${end_date}=           get_all_etender_dates   ${ARGUMENTS[1]}         EndDate            date
  ${end_time}=           get_all_etender_dates   ${ARGUMENTS[1]}         EndDate            time


  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  Sleep  5
  Click Element                     jquery=a[href^="#/profile"]
  Sleep  5
  Click Element                     xpath=//a[contains(@class, 'ng-binding')][./text()='Мої торги']
  Sleep  5
  Click Element                     xpath=//a[contains(@class, 'btn btn-info')]
  Sleep  3
  Input text    id=title                  ${title}
  Input text    id=description            ${description}
  Wait Until Page Contains Element  xpath=//input[@ng-model="data.enquiryPeriod.endDate"]
  Input text    xpath=//*[@id="myform"]/tender-form/div[5]/div/div[2]/div[1]/input   ${enquiry_end_date}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[5]/div/div[2]/div[2]/input   ${enquiry_end_time}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[1]/input   ${start_date}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[2]/input   ${start_time}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[3]/input   ${end_date}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[4]/input   ${end_time}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[1]/input   ${start_date}
  Sleep   1
  Input text    xpath=//*[@id="myform"]/tender-form/div[6]/div/div[2]/div[2]/input   ${start_time}
  # Sleep   1
  # Click Element    id=addLot_        ##click to button addLot
  # Sleep     2
  # Input text    id=lotTitle          ${title}
  # Sleep   1
  # Input text    id=lotDescription    ${description}
  Sleep   1
  ${budget}=  Convert To String  ${budget}
  Input text    id=value        ${budget}
  Sleep   1
  Click Element    id=valueAddedTaxIncluded
  ${step_rate}=  Convert To String  ${step_rate}
  Input text    id=minimalStep        ${step_rate}
  # Sleep   1
  # Input text    name=minimalStepPer_0     1
  # Sleep   1
  # Click Element    id=addLotItem_0
  Sleep    1
  Input text    id=itemsDescription0      ${items_description}
  Sleep   1
  Input text    id=itemsQuantity0         ${quantity}
  Click Element   xpath=//select[@id='itemsUnit0']//option[@label='кг.']
  Sleep  2
  Click Element   xpath=//select[@name='region']//option[@label='Київська']
  Sleep  2
  Click Element   xpath=//select[@name='city']//option[@label='Київ']
  Input text    name=addressStr   ${streetAddress}
  Sleep   1
  Input text    name=postIndex    ${postalCode}
  Sleep   1
#  Input text    id=latitude0    ${latitude}
#  Sleep   1
#  Input text    id=longitude0   ${longitude}
#  Sleep   1
  Input text    id=deliveryDate0        ${deliveryDate}
  Sleep  2
  Input text    id=deliveryDate_endDate          ${deliveryDate}
  Sleep   1
  Click Element  xpath=//input[starts-with(@ng-click, 'openClassificationModal')]
  Sleep  1
  Input text     xpath=//div[contains(@class, 'modal-content')]//input[@ng-model='searchstring']  ${cpv}
  Wait Until Element Is Visible  xpath=//td[contains(., '${cpv}')]
  Sleep  2
  Click Element  xpath=//td[contains(., '${cpv}')]
  Sleep  1
  Click Element  xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]
  Sleep  1
  Додати предмет   ${items[0]}   0
  Sleep   2
  Run Keyword if   '${mode}' == 'multi'   Додати багато предметів   items
  Sleep  1
  Wait Until Page Contains Element   xpath=//div[contains(@class, 'form-actions')]//button[@type='submit']
  Click Element   xpath=//div[contains(@class, 'form-actions')]//button[@type='submit']
  Sleep   60
  Reload Page
  Sleep  10
  Click Element   xpath=//*[text()='${title}']
  Sleep   5
  ${tender_UAid}=  Get Text  xpath=/html/body/div[2]/div/div[2]/div/div/div/div/div[1]/h3
  ${_}  ${tender_UAid}=  Split String  ${tender_UAid}
  Sleep  1
  Log   ${tender_UAid}
  ${Ids}=   Convert To String   ${tender_UAid}
  log to console      ${Ids}
  Log   ${Ids}
  Run keyword if   '${mode}' == 'multi'   Set Multi Ids   ${ARGUMENTS[0]}   ${tender_UAid}
  [return]  ${Ids}


Завантажити документ
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  file
  ...      ${ARGUMENTS[2]} ==  tender_uaid
  sleep   2
  Execute Javascript     $('#lot_doc_add:first').removeAttr('disabled','false');
  Sleep   10
  Log   Multiple docType dropdowns on page   WARN
  Select From List By Index  id=docType  1
  Sleep   10
  Choose File     id=lot_doc_add     ${ARGUMENTS[1]}
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



Клацнути і дочекатися
  [Arguments]  ${click_locator}  ${wanted_locator}  ${timeout}
  [Documentation]
  ...      click_locator: Where to click
  ...      wanted_locator: What are we waiting for
  ...      timeout: Timeout
  Click Link  ${click_locator}
  Wait Until Page Contains Element  ${wanted_locator}  ${timeout}


Шукати і знайти
  Клацнути і дочекатися  jquery=a[ng-click='search()']  jquery=a[href^="#/tenderDetailes"]  5


Пошук тендера по ідентифікатору
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  Go To  ${USERS.users['${ARGUMENTS[0]}'].homepage}
  Wait Until Page Contains   Прозорі аукціони    10
  sleep  1
  Wait Until Page Contains Element    xpath=//input[@type='text']    10
  sleep  1
  Wait Until Element Is Visible    xpath=//input[@type='text']    10
  sleep  3
  Input Text    xpath=//input[@type='text']    ${ARGUMENTS[1]}
  sleep  2
  ${timeout_on_wait}=  Get Broker Property By Username  ${ARGUMENTS[0]}  timeout_on_wait
  ${passed}=  Run Keyword And Return Status  Wait Until Keyword Succeeds  ${timeout_on_wait} s  0 s  Шукати і знайти
  Run Keyword Unless  ${passed}  Fatal Error  Тендер не знайдено за ${timeout_on_wait} секунд
  sleep  3
  Wait Until Page Contains Element    jquery=a[href^="#/tenderDetailes"]    10
  sleep  1
  Click Link    jquery=a[href^="#/tenderDetailes"]
  Wait Until Page Contains    ${ARGUMENTS[1]}   10
  sleep  1


Завантажити документ в ставку
  [Arguments]  @{ARGUMENTS}
  [Documentation]
    ...    ${ARGUMENTS[0]} ==  username
    ...    ${ARGUMENTS[1]} ==  file
    ...    ${ARGUMENTS[2]} ==  tenderId
  Selenium2Library.Switch Browser     ${ARGUMENTS[0]}
  sleep   4
 # Choose File     xpath=(//button[@name='file'][contains(text(), 'Додати файл')])[2]      ${ARGUMENTS[1]}
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
  Choose File       id=updatebid_doc_add     ${ARGUMENTS[1]}
  Sleep   2

Подати цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} ==  ${test_bid_data}
  ${amount}=    Get From Dictionary     ${ARGUMENTS[2].data.value}         amount
  sleep  60
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  sleep  15
  Input text    xpath=//input[@name='amount']                  ${amount}
  Click Element                     xpath=/html/body/div[2]/div/div[2]/div[2]/div/div/div/div[2]/div/tender-bids/div[2]/div/form/div[3]/div[2]/button
  sleep  3
  # Click Element    xpath=//*[@id="modalAddBidWarning"]/div/div/div[3]/div[2]/button[1]
  # sleep  5
  Capture Page Screenshot

Змінити цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  ...      ${ARGUMENTS[2]} ==  ${test_bid_data}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Sleep    5
  Input text    xpath=//input[@name='amount']        510
  Sleep    3
  Click Element                      xpath=//div[3]/button

Скасувати цінову пропозицію
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  ${TENDER_UAID}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Sleep  3
  Click Element               xpath=//button[contains(@class, 'btn-sm btn-danger')]
  sleep  5

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
  Sleep  20
  Click Element                      xpath=//a[contains(@href,'#/addQuestion/')]
  Wait Until Page Contains Element   id=title
  Sleep  2
  Input text                         id=title                 ${title}
  Input text                         xpath=//*[@id=" description"]           ${description}
  Click Element                      xpath=//button[@type='submit']

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
  sleep   10
  Click Element                      id=addAnswer_0
  Input text                         xpath=//*[@id="questionContainer"]/form/div/textarea            ${answer}
  sleep   2
  Click Element                      xpath=//*[@id="questionContainer"]/form/div/span/button[1]
  sleep  5

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
  Wait Until Page Contains Element   xpath=//a[@class='btn btn-primary ng-scope']   10
  Click Element              xpath=//a[@class='btn btn-primary ng-scope']
  Sleep  2
  Input text               id=description    ${description}
  Click Element            id=SaveChanges


Отримати інформацію із тендера
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  fieldname
  Switch browser   ${ARGUMENTS[0]}
  Run Keyword And Return  Отримати інформацію про ${ARGUMENTS[1]}

Отримати текст із поля і показати на сторінці
  [Arguments]   ${fieldname}
  Wait Until Page Contains Element    ${locator.${fieldname}}    1
  ${return_value}=   Get Text  ${locator.${fieldname}}
  [return]  ${return_value}

Отримати інформацію про title
  ${return_value}=   Отримати текст із поля і показати на сторінці   title
  [return]  ${return_value}

Отримати інформацію про description
  ${return_value}=   Отримати текст із поля і показати на сторінці   description
  [return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці   minimalStep.amount
  ${return_value}=  Catenate  @{return_value.split(' ')[:-1]}
  ${return_value}=   Convert To Number   ${return_value}
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  [return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  value
  ${return_value}=  Catenate  @{return_value.split(' ')[:-3]}
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryLocation
  ${return_value}=   string_to_float   ${return_value.split(',')[0]}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].deliveryLocation
  #${return_value}=   Convert To Number   ${return_value}
  ${return_value}=   string_to_float   ${return_value.split(',')[1]}
  [return]  ${return_value}

Отримати інформацію про value.currency
  ${return_value}=   Отримати текст із поля і показати на сторінці   value
  [return]  ${return_value.split(' ')[-3]}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=   Отримати текст із поля і показати на сторінці   value.valueAddedTaxIncluded
  ${return_value}=  Run Keyword If  'ПДВ' in '${return_value}'  Set Variable  True
    ...  ELSE  Set Variable  False
  Log  ${return_value}
  ${return_value}=   Convert To Boolean   ${return_value}
  [return]  ${return_value}


Отримати інформацію про items[0].unit.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  ${return_value}=   convert_etender_string_to_common_string   ${return_value.split(' ')[-1]}
  [return]  ${return_value}


Відмітити на сторінці поле з тендера
  [Arguments]   ${fieldname}  ${locator}
  ${last_note_id}=  Add pointy note   ${locator}   Found ${fieldname}   width=200  position=bottom
  Align elements horizontally    ${locator}   ${last_note_id}
  sleep  1
  Remove element   ${last_note_id}

Отримати інформацію про auctionId
  ${return_value}=   Отримати текст із поля і показати на сторінці   auctionId
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.startDate
  ${return_value}=   Change_date_to_month   ${return_value}
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=   Change_date_to_month   ${return_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=   Change_date_to_month   ${return_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=   Change_date_to_month   ${return_value}
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
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  Run Keyword And Return If  '${return_value.split(' ')[1]}'== 'кг.'   Convert To String  KGM

Отримати інформацію про items[0].quantity
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[0].quantity
  ${return_value}=   Convert To Number   ${return_value.split(' ')[0]}
  [return]  ${return_value}

Отримати інформацію про items[0].classification.id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.id
  [return]  ${return_value.split(' ')[0]}

Отримати інформацію про items[0].classification.scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.scheme
  ${return_value}=   Get Substring  ${return_value}   0   -1
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про items[0].classification.description
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].classification.id
  ${return_value}=  Catenate  @{return_value.split(' ')[1:]}
  Run Keyword And Return  convert_etender_string_to_common_string  ${return_value}

Отримати інформацію про items[0].additionalClassifications[0].id
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].id
  [return]  ${return_value.split(' ')[0]}

Отримати інформацію про items[0].additionalClassifications[0].scheme
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].scheme
  ${return_value}=   Get Substring  ${return_value}   0   -1
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про items[0].additionalClassifications[0].description
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].additionalClassifications[0].id
  ${return_value}=  Catenate  @{return_value.split(' ')[1:]}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  Run Keyword And Return  Get Substring  ${return_value}  0  5

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.countryName
  Run Keyword And Return  Get Substring  ${return_value}  0  7

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.region
  ${return_value}=    convert_etender_string_to_common_string     ${return_value[:-1]}
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
  [return]  ${return_value}

Отримати інформацію про questions[0].description
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [return]  ${return_value}

Отримати інформацію про questions[0].date
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  ${return_value}=   Change_date_to_month   ${return_value}
  [return]  ${return_value}


Отримати інформацію про questions[0].answer
  Sleep   3
  Reload Page
  Sleep   10
  ${return_value}=     Отримати текст із поля і показати на сторінці     questions[0].answer
  Sleep   4
  ${return_value}=    Get text   xpath=//div[@textarea='question.answer']
  [return]  ${return_value}
  Capture Page Screenshot

Отримати інформацію про status
  ${status}=   Отримати текст із поля і показати на сторінці   status
  ${return_value}=   Run Keyword If  '${status}' == "Період аукціону"  Set Variable  active.auction
  ${return_value}=   Run Keyword If  '${status}' == "Період уточнень"  Set Variable  active.enquiry
  ${return_value}=   Run Keyword If  '${status}' == "Очікування пропозицій"  Set Variable  active.tendering
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
