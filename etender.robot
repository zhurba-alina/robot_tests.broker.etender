*** Settings ***
Library  Selenium2Screenshots
Library  Selenium2Library
Library  String
Library  DateTime
Library  etender_service.py

*** Variables ***
${locator.tenderId}                                            xpath=//*[@id='tenderidua']/b
${locator.title}                                               id=tenderTitle
${locator.description}                                         id=tenderDescription
${locator.minimalStep.amount}                                  id=lotMinimalStep_0
${locator.procuringEntity.name}                                id=tenderOwner
${locator.value.amount}                                        id=tenderBudget
${locator.tenderPeriod.startDate}                              id=tenderStart
${locator.tenderPeriod.endDate}                                id=tenderEnd
${locator.enquiryPeriod.startDate}                             id=enquiryStart
${locator.enquiryPeriod.endDate}                               id=enquiryEnd
${locator.items[0].description}                                id=item_description_00
${locator.items[0].deliveryDate.startDate}                     id=delivery_start_00
${locator.items[0].deliveryDate.endDate}                       id=delivery_end_00
${locator.items[0].deliveryLocation.latitude}                  id=delivery_latitude0
${locator.items[0].deliveryLocation.longitude}                 id=delivery_longitude0
${locator.items[0].deliveryAddress.postalCode}                 id=delivery_postIndex_00
${locator.items[0].deliveryAddress.countryName}                id=delivery_country_00
${locator.items[0].deliveryAddress.region}                     id=delivery_region_00
${locator.items[0].deliveryAddress.locality}                   id=delivery_city_00
${locator.items[0].deliveryAddress.streetAddress}              id=delivery_addressStr_00
${locator.items[0].classification.scheme}                      xpath=//table[contains(@class,"itemTable")]//th[contains(.,"Класифікатор ")]
${locator.items[0].classification.id}                          id=classification_code_00
${locator.items[0].classification.description}                 id=classification_name_00
${locator.items[0].additionalClassifications[0].scheme}        xpath=//div[6]/div[3]/div/p
${locator.items[0].additionalClassifications[0].id}            id=additionalClassification_id0
${locator.items[0].additionalClassifications[0].description}   id=additionalClassification_desc0
${locator.items[0].unit.code}                                  id=item_unit_00
${locator.items[0].quantity}                                   id=item_quantity_00
${locator.items[0].unit.name}                                  id=item_unit_00
${locator.questions[0].title}                                  id=quest_title_0
${locator.questions[0].description}                            id=quest_descr_0
${locator.questions[0].date}                                   id=quest_date_0
${locator.questions[0].answer}                                 id=question_answer_0
${locator_document_title}                                      xpath=//td[contains(@class,"doc-name")]//a[contains(.,"XX_doc_id_XX")]
${locator_document_href}                                       xpath=//td[contains(@class,"doc-name")]//a[contains(.,"XX_doc_id_XX")]@href
${locator_document_description}                                xpath=//td[contains(@class,"doc-name")]//a[contains(.,"XX_doc_id_XX")]/following-sibling::p
${locator.value.currency}                                      id=tenderCurrency
${locator.value.valueAddedTaxIncluded}                         id=includeVat
${locator.bids}                                                id=ParticipiantInfo_0
${locator_block_overlay}                                       xpath=//div[@class='blockUI blockOverlay']
${locator_question_title}                                      xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]
${huge_timeout_for_visibility}                                 300


*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  @{ARGUMENTS}
  [Documentation]  Відкрити браузер, створити об’єкт api wrapper, тощо
  Open Browser  ${USERS.users['${ARGUMENTS[0]}'].homepage}  ${USERS.users['${ARGUMENTS[0]}'].browser}  alias=${ARGUMENTS[0]}
  Set Window Size  @{USERS.users['${ARGUMENTS[0]}'].size}
  Set Window Position  @{USERS.users['${ARGUMENTS[0]}'].position}
  Run Keyword If  '${ARGUMENTS[0]}' != 'Etender_Viewer'  Login  ${ARGUMENTS[0]}


Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${username_2}
  ${tender_data}=  change_data  ${tender_data}
  Log  ${tender_data}
  Log  ${username}
  Log  ${username_2}
  [return]  ${tender_data}


Login
  [Arguments]  @{ARGUMENTS}
  Wait Until Page Contains Element   css=a.login    180
  Click Link    css=a.login
  Wait Until Page Contains Element   id=inputUsername   180
  Input text   id=inputUsername      ${USERS.users['${ARGUMENTS[0]}'].login}
  Wait Until Page Contains Element   id=inputPassword   180
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
  ${budgetToStr}=       float_to_string_2f      ${budget}      # at least 2 fractional point precision, avoid rounding
  ${step_rate}=         Get From Dictionary     ${ARGUMENTS[1].data.minimalStep}   amount
  ${step_rateToStr}=    float_to_string_2f      ${step_rate}   # at least 2 fractional point precision, avoid rounding
  ${enquiry_end_date}=   get_all_etender_dates   ${ARGUMENTS[1]}         EndPeriod          date
  ${enquiry_end_time}=   get_all_etender_dates   ${ARGUMENTS[1]}         EndPeriod          time
  ${start_date}=         get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          date
  ${start_time}=         get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          time
  ${end_date}=           get_all_etender_dates   ${ARGUMENTS[1]}         EndDate            date
  ${end_time}=           get_all_etender_dates   ${ARGUMENTS[1]}         EndDate            time

  ${methodType}=         Set Variable  ${EMPTY}
  ${status}  ${methodType}=  Run Keyword And Ignore Error  Get From Dictionary  ${ARGUMENTS[1].data}  procurementMethodType
  log to console  check presence of procurementMethodType in dictionary: ${status}
  ${methodType}=  Run Keyword IF  '${status}' != 'PASS'  Set Variable  belowThreshold
  ...             ELSE  Set Variable  ${methodType}

  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  Sleep  15
  Click Element                     id=qa_myTenders  # Мої закупівлі
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Element Is Visible     xpath=//a[@data-target='#procedureType']  # Створити оголошення
  Sleep  10
  Click Element                     xpath=//a[@data-target='#procedureType']  # Створити оголошення
  Sleep  3

  &{procedure_types}=  Create Dictionary  aboveThresholdUA=Відкриті торги  belowThreshold=Допорогові закупівлі
  Select From List By Label         id=chooseProcedureType  &{procedure_types}[${methodType}]
  Sleep  3

  Click Element                     id=goToCreate  # Продовжити
  Sleep   3
  Input text    id=title                  ${title}
  Input text    id=description            ${description}

  ${status}	           ${value}=  Run Keyword And Ignore Error  Should Not Be Empty  ${enquiry_end_date}
  log to console       check do we have enquiry_end_date: ${status}
  Run Keyword If      '${status}' == 'PASS'  Enter enquiry date  ${enquiry_end_date}  ${enquiry_end_time}

  Run Keyword If  '${methodType}' != 'aboveThresholdUA'  Input text    xpath=//input[@id="startDate"]   ${start_date}
  Sleep   1
  Run Keyword If  '${methodType}' != 'aboveThresholdUA'  Input text    xpath=//input[@id="startDate_time"]   ${start_time}
  Sleep   1
  Input text    xpath=//input[@id="endDate"]   ${end_date}
  Sleep   1
  Input text    xpath=//input[@id="endDate_time"]   ${end_time}
  Sleep   1
#  Click Element    id=addLot_        ##click to button addLot
#  Sleep     2
#  Input text    id=lotTitle          ${title}
#  Sleep   1
#  Input text    id=itemsDescription00   ${description}
#  Sleep   1
  Input text    id=lotValue_0        ${budgetToStr}
  Sleep   1
  Click Element    xpath=//div[contains(@class,'row') and (not(contains(@class,'controls')))]/div/label/input[@id='valueAddedTaxIncluded']
  Input text    id=minimalStep_0        ${step_rateToStr}
  Sleep   1
  #Input text    name=minimalStepPer_0     1
#  Sleep   1
#  Click Element    id=addLotItem_0
#  Sleep    2
  Додати предмет   ${items[0]}   0
  Sleep   2
  Run Keyword if   '${mode}' == 'multi'   Додати багато предметів   items
  Sleep  1
  Wait Until Page Contains Element   id=createTender
  Click Element   id=createTender
  Sleep   60
  Reload Page
  Wait Until Keyword Succeeds        10 min  20 x  Дочекатися завершення обробки тендера
  ${tender_UAid}=  Get Text  ${locator.tenderId}
  Sleep  1
  Log   ${tender_UAid}
  ${Ids}=   Convert To String   ${tender_UAid}
  log to console      ${Ids}
  Log   ${Ids}
  Run keyword if   '${mode}' == 'multi'   Set Multi Ids   ${ARGUMENTS[0]}   ${tender_UAid}
  [return]  ${Ids}

Створити план
  [Arguments]  ${username}  ${arguments}
#  [Documentation]
#  ...      ${ARGUMENTS[0]} ==  username
#  ...      ${ARGUMENTS[1]} ==  plan_data
  Log  ${arguments}
  ${plan}=              Get From Dictionary     ${arguments}                    data
  ${items}=             Get From Dictionary     ${plan}                         items
  ${description}=       Get From Dictionary     ${plan.budget}                  description
  ${amount}=            Get From Dictionary     ${plan.budget}                  amount
  ${amount}=            float_to_string_2f      ${amount}
  ${number_of_items}=   Get Length              ${items}
  ${cpv_id}=          Get From Dictionary       ${plan.classification}          id
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Element Is Visible     id=qa_myPlans
  Click Element         id=qa_myPlans
  Wait Until Element Is Visible     jquery=a[href^="#/createPlan"]
  Click element         jquery=a[href^="#/createPlan"]
  Wait Until Element Is Visible     id=description
  Input text            id=description          ${description}
  Input text            id=value                ${amount}
  Select From List By Index     xpath=//select[@name="startDateMonth"]          6
  Click element         css=input.btn-cpv
  Wait Until Element Is Visible     css=#planClassification input
  Input text            css=#planClassification input                           ${cpv_id}
  Sleep  3
  Click element         xpath=//td[contains(.,'${cpv_id}')]
  Click element         xpath=//button[contains(.,'Зберегти та вийти')]
  :FOR  ${i}  IN RANGE  ${number_of_items}
  \     Wait Until Element Is Visible       //button[@ng-click="addItem()"]
  \     scrollIntoView by script using xpath  //button[@ng-click="addItem()"]
  \     Click element           xpath=//button[@ng-click='addItem()']
  \     ${item_description}=    Get From Dictionary         ${items[${i}]}          description
  \     Input text              id=itemsDescription${i}     ${item_description}
  \     ${item_quantity}=       Get From Dictionary         ${items[${i}]}          quantity
  \     Input text              id=itemsQuantity${i}        ${item_quantity}
  \     ${item_unit}=           Get From Dictionary         ${items[${i}].unit}     name
  \     Input text              xpath=//unit[@id='unit_${i}']//input[@type="search"]                 ${item_unit}
  \     Press Key               xpath=//unit[@id='unit_${i}']//input[@type="search"]                 \\13
  \     Sleep   2
  \     Click Element           xpath=//div[contains(@ng-model,'unit.selected')]//span[@class="ui-select-highlight"]
  scrollIntoView by script using xpath  //button[contains(., "Створити план")]
  Click element         xpath=//button[contains(., 'Створити план')]
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Keyword Succeeds   2x  10 sec  Дочекатися завершення обробки плану
  ${plan_id}=                        Get Text  id=planId_0
  [Return]  ${plan_id}


Опрацювати дотаткові класифікації
  [Arguments]  ${additionalClassifications}
  # TODO: Обробляти випадок коли є більше однієї додаткової класифікації
  ${scheme}=  Get From Dictionary  ${additionalClassifications[0]}  scheme
  Run Keyword And Return  Вказати ${scheme} дотаткову класифікацію  ${additionalClassifications[0]}

Вказати INN дотаткову класифікацію
  [Arguments]  ${additionalClassification}
  ${description}=  Get From Dictionary  ${additionalClassification}  description
  Click Element  xpath=//input[@id='openAddClassificationInnModal00']
  Sleep  3
  Input text     xpath=//div[@id="addClassificationInn_0_0" and contains(@class,"top")]//input  ${description}
  Wait Until Element Is Visible  xpath=//td[contains(., '${description}')]
  Sleep  2
  Click Element  xpath=//td[contains(., '${description}')]
  Sleep  1
  Click Element  xpath=//div[@id="addClassificationInn_0_0" and contains(@class,"top")]//button[@id="addClassification_choose"]

Вказати ДК003 дотаткову класифікацію
  [Arguments]  ${additionalClassification}
  ${description}=  Get From Dictionary  ${additionalClassification}  description
  Click Element  id=openAddClassificationModal000
  Sleep  3
  Select From List By Value  xpath=//div[@id="addClassification" and contains(@class,"modal")]//select[@name="dkScheme"]  ДК003
  Sleep  3
  Input text     xpath=//div[@id="addClassification" and contains(@class,"modal")]//input  ${description}
  Wait Until Element Is Visible  xpath=//td[contains(., '${description}')]
  Sleep  2
  Click Element  xpath=//td[contains(., '${description}')]
  Sleep  1
  Click Element  xpath=//div[@id="addClassification" and contains(@class,"modal")]//*[@id="addClassification_choose"]

Вказати ДК018 дотаткову класифікацію
  [Arguments]  ${additionalClassification}
  ${description}=  Get From Dictionary  ${additionalClassification}  description
  Click Element  id=openAddClassificationModal000
  Sleep  3
  Select From List By Value  xpath=//div[@id="addClassification" and contains(@class,"modal")]//select[@name="dkScheme"]  ДК018
  Sleep  3
  Input text     xpath=//div[@id="addClassification" and contains(@class,"modal")]//input  ${description}
  Wait Until Element Is Visible  xpath=//td[contains(., '${description}')]
  Sleep  2
  Click Element  xpath=//td[contains(., '${description}')]
  Sleep  1
  Click Element  xpath=//div[@id="addClassification" and contains(@class,"modal")]//*[@id="addClassification_choose"]

Вказати ДКПП дотаткову класифікацію
  [Arguments]  ${additionalClassification}
  log  Це щось старе, і його мають прибрати. Не буду нічого тут робити!  WARN

Enter enquiry date
  [Arguments]  ${enquiry_end_date}  ${enquiry_end_time}
  Input text    xpath=//input[@id="enquiryPeriod"]   ${enquiry_end_date}
  Sleep   1
  Input text    xpath=//input[@id="enquiryPeriod_time"]   ${enquiry_end_time}
  Sleep   1


Дочекатися завершення обробки тендера
  Reload Page
  Sleep   25
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Element Is Visible      ${locator.tenderId}  30
  ${tender_id}=                      Get Text  ${locator.tenderId}
  Should Match Regexp                ${tender_id}  UA-\\d{4}-\\d{2}-\\d{2}-\\d+.*


Дочекатися завершення обробки плану
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Element Is Visible      id=planId_0  30
  ${plan_id}=                        Get Text  id=planId_0
  Log  ${plan_id}
  Should Match Regexp                ${plan_id}  UA-P-\\d{4}-.*

Завантажити документ
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  username
  ...      ${ARGUMENTS[1]} ==  file
  ...      ${ARGUMENTS[2]} ==  tender_uaid
  sleep   2
  Select From List By Label  xpath=//div[@id="tree-01-02"]//select[@id="docType"]  Інші
  log  ${ARGUMENTS[1]}
  Sleep   10
  # TODO: Rework this tricky behavior someday?
  # Autotest cannot upload file directly, because there is no INPUT element on page. Need to click on button first,
  # but this will open OS file selection dialog. So we close and reopen browser to get rid of this dialog
  ${tmp_location}=  Get Location
  Click Element   id=tend_doc_add
  Choose File     xpath=//input[@type="file"]  ${ARGUMENTS[1]}
  Sleep   4
  Capture Page Screenshot
  Close Browser
  etender.Підготувати клієнт для користувача  ${ARGUMENTS[0]}
  Go To  ${tmp_location}
  Sleep  5

Додати предмет
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} ==  items
  ...      ${ARGUMENTS[1]} ==  ${INDEX}
  # TODO: rework this, change ARGUMENTS list to named arguments;
  # TODO: change items[0] below to item argument
  ${items}=  Set Variable  ${ARGUMENTS}
  ${items_description}=   Get From Dictionary   ${items[0]}                       description
  ${quantity}=          Get From Dictionary     ${items[0]}                       quantity
  ${unit}=              Get From Dictionary     ${items[0].unit}                  name
  ${cpv}=               Get From Dictionary     ${items[0].classification}        id
  ${dkpp_desc}=     Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   description
  ${dkpp_id}=       Get From Dictionary   ${ARGUMENTS[0].additionalClassifications[0]}   id
  ${deliveryDateStart}=    Get From Dictionary  ${items[0].deliveryDate}          startDate
  ${deliveryDateEnd}=      Get From Dictionary  ${items[0].deliveryDate}          endDate
  ${deliveryDateStart}=    convert_date_to_etender_format        ${deliveryDateStart}
  ${deliveryDateEnd}=      convert_date_to_etender_format        ${deliveryDateEnd}
  ${latitude}=          Get From Dictionary     ${items[0].deliveryLocation}      latitude
  ${longitude}=         Get From Dictionary     ${items[0].deliveryLocation}      longitude
  ${region}=            Get From Dictionary     ${items[0].deliveryAddress}       region
  ${region}=            convert_common_string_to_etender_string                   ${region}
  ${locality}=          Get From Dictionary     ${items[0].deliveryAddress}       locality
  ${postalCode}=        Get From Dictionary     ${items[0].deliveryAddress}       postalCode
  ${streetAddress}=     Get From Dictionary     ${items[0].deliveryAddress}       streetAddress

  Sleep  1
  Input text    id=itemsDescription00      ${items_description}
  Sleep  1
  Input text    id=itemsQuantity00         ${quantity}
  Click Element   xpath=//div[contains(@ng-model,'unit.selected')]//input
  Sleep  3
  Input text    xpath=//input[@type='search']  ${unit}
  Sleep  2
  Click Element   xpath=//div[contains(@class,"selectize-dropdown") and contains(@repeat,"unit")]//div[@role="option" and contains(@class,"active")]
  Sleep  1
  Click Element  xpath=//input[starts-with(@ng-click, 'openClassificationModal')]
  Sleep  1
  Input text     id=classificationCode  ${cpv}
  Wait Until Element Is Visible  xpath=//td[contains(., '${cpv}')]
  Sleep  2
  Click Element  xpath=//td[contains(., '${cpv}')]
  Sleep  1
  Click Element  id=classification_choose
  Sleep  3
  ${status}  ${value}=  Run Keyword And Ignore Error  Get From Dictionary  ${items[0]}  additionalClassifications
  log to console       Attempt to get 1st additonal classification scheme: ${status}
  Run Keyword If      '${status}' == 'PASS'   Опрацювати дотаткові класифікації  ${items[0].additionalClassifications}
#  Input text    id=latitude0    ${latitude}
#  Sleep   1
#  Input text    id=longitude0   ${longitude}
  Sleep  2
  Input text    id=delStartDate00        ${deliveryDateStart}
  Sleep  2
  Input text    id=delEndDate00          ${deliveryDateEnd}
  Sleep  2
  Select From List By Label  id=region_00  ${region}
  Sleep  2
  Select From List By Label  id=city_00  ${locality}
  Input text    id=street_00   ${streetAddress}
  Sleep  1
  Input text    id=postIndex_00    ${postalCode}


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
  Run Keyword If  '${ARGUMENTS[0]}' == 'Etender_Viewer'  Run Keyword And Return  Тимчасовий Пошук тендера по ідентифікатору для Viewer  ${ARGUMENTS[0]}  ${ARGUMENTS[1]}
  Wait Until Page Contains Element    xpath=//input[@type='text' and @placeholder='Пошук за номером закупівлі']    10
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  sleep  1
  Wait Until Element Is Visible    xpath=//input[@type='text' and @placeholder='Пошук за номером закупівлі']    10
  sleep  3
  Input Text    xpath=//input[@type='text' and @placeholder='Пошук за номером закупівлі']    ${ARGUMENTS[1]}
  sleep  2
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  ${timeout_on_wait}=  Get Broker Property By Username  ${ARGUMENTS[0]}  timeout_on_wait
  ${passed}=  Run Keyword And Return Status  Wait Until Keyword Succeeds  ${timeout_on_wait} s  0 s  Шукати і знайти
  Run Keyword Unless  ${passed}  Fatal Error  Тендер не знайдено за ${timeout_on_wait} секунд
  sleep  3
  Wait Until Element Is Visible    xpath=//td[contains(.,'${ARGUMENTS[1]}')]/p/a[contains(@href,'#/tenderDetailes')]  10
  Wait Until Element Is Enabled    xpath=//td[contains(.,'${ARGUMENTS[1]}')]/p/a[contains(@href,'#/tenderDetailes')]  20
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  sleep  1
  Click Link    xpath=//td[contains(.,'${ARGUMENTS[1]}')]/p/a[contains(@href,'#/tenderDetailes')]
  Wait Until Page Contains    ${ARGUMENTS[1]}   10
  sleep  1

Тимчасовий Пошук тендера по ідентифікатору для Viewer
  [Arguments]  ${username}  ${TENDER_UAID}
  # TODO: У майбутньому треба буде запровадити більш коректне рішення
  # Виникла необхідність обійти пошук по ідентифікатору через особливість тестового оточення майданчика
  ${cleared_homepage_site}=  Set Variable  ${USERS.users['${username}'].homepage}
  ${cleared_homepage_site}=  Set Variable  ${cleared_homepage_site.split('#')[0]}
  Go To  ${cleared_homepage_site}tender?tenderid=${TENDER_UAID}

Пошук плану по ідентифікатору
  [Arguments]  ${username}  ${TENDER_UAID}
  Log  ${username}
  Go To  ${USERS.users['${username}'].homepage}
  Wait Until Element Is Visible         id=naviTitle2
  Sleep  3
  JavaScript scrollBy  0  -2000
  Click Element                         id=naviTitle2
  #Wait Until Page Contains Element    xpath=//input[@type='text' and @placeholder='Пошук за номером плану']    10
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  sleep  1
  Wait Until Element Is Visible    xpath=//input[@type='text' and @placeholder='Пошук за номером плану']    10
  sleep  3
  Input Text    xpath=//input[@type='text' and @placeholder='Пошук за номером плану']   ${TENDER_UAID}
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Wait Until Page Contains  ${TENDER_UAID}  10


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
  Input text    xpath=//input[@name='amount0']                  ${amount}
  Click Element                     xpath=//div[@id='addBidDiv']//button[@class="btn btn-success"][contains(text(), 'Реєстрація пропозиції')]
  sleep  3
  Click Element    xpath=//div[@id='modalAddBidWarning']//button[@class='btn btn-success']
  sleep  10
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

Оновити сторінку з планом
  [Arguments]  @{ARGUMENTS}
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
  Input text                         id=description           ${description}
  Click Element                      xpath=//button[@type='submit']

Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  ${answer}=     Get From Dictionary  ${answer_data.data}  answer
  Selenium2Library.Switch Browser    ${username}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  sleep   10
  Відкрити розділ запитань
  sleep   10
  scrollIntoView by script using xpath  //*[@id="addAnswer_0"]  # scroll to addAnswer button
  sleep   4
  JavaScript scrollBy  0  -100
  sleep   4
  Click Element                      id=addAnswer_0

  scrollIntoView by script using xpath  //*[@id="questionContainer"]/form/div/textarea  # scroll to questionContainer
  sleep   4
  JavaScript scrollBy  0  -100
  sleep   4
  Input text                         xpath=//*[@id="questionContainer"]/form/div/textarea            ${answer}

  sleep   2
  scrollIntoView by script using xpath  //*[@id="questionContainer"]/form/div/span/button[1]  # scroll to submit answer V-button
  sleep   4
  JavaScript scrollBy  100  -100
  sleep   4
  Click Element                      xpath=//*[@id="questionContainer"]/form/div/span/button[1]
  sleep  5

Відкрити розділ запитань
  scrollIntoView by script using xpath  //li[@id="naviTitle2"]/span  # scroll to questions tab
  sleep   4
  JavaScript scrollBy  0  -100
  sleep   4
  Click Element                      xpath=//li[@id="naviTitle2"]/span  # go to questions tab

scrollIntoView by script using xpath
  [Arguments]  ${xpath_locator}
  Execute JavaScript  document.evaluate('${xpath_locator}', document.documentElement, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).scrollIntoView();

JavaScript scrollBy
  [Arguments]  ${x_offset}  ${y_offset}
  Execute JavaScript  window.scrollBy(${x_offset}, ${y_offset})

Check Is Element Loaded
  [Arguments]  ${locator}
  ${text_value}=   Get Text  ${locator}
  Log  ${text_value}
  Should Not Be Empty  ${text_value}
  Should Not Be Equal  ${text_value}  -

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${field}  ${new_value}
  ${description}=   Convert To String    новое описание тендера
  Selenium2Library.Switch Browser    ${username}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Execute Javascript   window.scrollTo(0, document.body.scrollHeight)
  Wait Until Page Contains Element   xpath=//a[contains(@class,'btn btn-primary') and .='Редагувати закупівлю']   ${huge_timeout_for_visibility}
  Sleep  2
  Click Element              xpath=//a[contains(@class,'btn btn-primary') and .='Редагувати закупівлю']
  Sleep  2
  Редагувати поле тендера  ${field}  ${new_value}
  Sleep  2
  Execute Javascript   window.scrollTo(0, document.body.scrollHeight)
  Click Element            id=SaveChanges

Редагувати поле тендера
  [Arguments]  ${field}  ${new_value}
  Run Keyword And Return  Редагувати поле ${field}  ${new_value}

Редагувати поле tenderPeriod.endDate
  [Arguments]  ${new_value_isodate}
  ${date}=  convert_date_to_etender_format  ${new_value_isodate}
  Input text  id=endDate  ${date}
  ${time}=  convert_time_to_etender_format  ${new_value_isodate}
  Input text  id=endDate_time  ${time}

Редагувати поле description
  [Arguments]  ${new_value}
  Input text  id=description  ${new_value}

Отримати інформацію із тендера
  [Arguments]  ${user}  ${tender_id}  ${fieldname}
  [Documentation]
  ...      Викликає кейворди для отримання відповідних полів. Неявно очікує що сторінка аукціона вже відкрита
  Switch browser   ${user}
  Run Keyword And Return  Отримати інформацію про ${fieldname}

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
  ${return_value}=   parse_currency_value_with_spaces   ${return_value}
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=   Отримати текст із поля і показати на сторінці  value.amount
  ${return_value}=   Set Variable  ${return_value.replace(u'\xa0','')}  # nbsp converting attempt
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

Отримати інформацію про tenderId
  ${return_value}=   Отримати текст із поля і показати на сторінці   tenderId
  [return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=   Отримати текст із поля і показати на сторінці   procuringEntity.name
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.startDate
  ${return_value}=   Set Variable  ${return_value.replace(u'з ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
#  ${return_value}=   Change_date_to_month   ${return_value}
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  tenderPeriod.endDate
  ${return_value}=   Set Variable  ${return_value.replace(u'по ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.startDate
  ${return_value}=  Set Variable  ${return_value.replace(u'з ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${return_value}=   Отримати текст із поля і показати на сторінці  enquiryPeriod.endDate
  ${return_value}=   Set Variable  ${return_value.replace(u'по ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}
#  ${return_value}=   Change_date_to_month   ${return_value}
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
  ${return_value}=   Set Variable  ${return_value.split(u'КЛАСИФІКАТОР ')[1]}
  ${return_value}=   Set Variable  ${return_value.split(':')[0]}
  ${return_value}=   Set Variable  ${return_value.replace(' ', '')}
  [return]  ${return_value}

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

Отримати інформацію про items[0].deliveryDate.startDate
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryDate.startDate
  ${return_value}=   Set Variable  ${return_value.replace(u'з ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}, 00:00
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryDate.endDate
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryDate.endDate
  ${return_value}=   Set Variable  ${return_value.replace(u'по ','')}
  ${return_value}=   convert_etender_date_to_iso_format   ${return_value}, 00:00
  [return]  ${return_value}

Отримати інформацію про questions[0].title
  sleep   10
  Відкрити розділ запитань
  sleep   10
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].title
  [return]  ${return_value}

Отримати інформацію про questions[0].description
  Sleep   10
  Відкрити розділ запитань
  Sleep   10
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].description
  [return]  ${return_value}

Отримати інформацію про questions[0].date
  Sleep   3
  ${return_value}=   Отримати текст із поля і показати на сторінці   questions[0].date
  [return]  ${return_value}


Отримати інформацію про questions[0].answer
  Sleep   3
  Reload Page
  Sleep   10
  Відкрити розділ запитань
  Sleep   10
  ${return_value}=     Отримати текст із поля і показати на сторінці     questions[0].answer
  [return]  ${return_value}


Отримати посилання на аукціон для глядача
  [Arguments]  @{ARGUMENTS}
  etender.Пошук тендера по ідентифікатору   ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Sleep  60
  Page Should Contain Element  xpath=//p[contains(@ng-if,"auctionUrl")]/a
  Sleep  3
  ${url}=  Get Element Attribute  xpath=//p[contains(@ng-if,"auctionUrl")]/a@href
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
  Fail  Temporary using keyword 'Отримати інформацію із тендера' until will be updated keyword 'Отримати інформацію із предмету'

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field}
  Switch browser   ${username}
  Reload Page
  ${prepared_locator}=  Set Variable  ${locator_question_${field}.replace('XX_que_id_XX','${question_id}')}
  log  ${prepared_locator}
  sleep   10
  Відкрити розділ запитань
  sleep   10
  Wait Until Page Contains Element  ${prepared_locator}  10
  Wait Until Keyword Succeeds  10 x  5  Check Is Element Loaded  ${prepared_locator}
  ${raw_value}=   Get Text  ${prepared_locator}
  Run Keyword And Return  Конвертувати інформацію із запитання про ${field}  ${raw_value}

Конвертувати інформацію із запитання про title
  [Arguments]  ${return_value}
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

Конвертувати інформацію із документа про description
  [Arguments]  ${raw_value}
  ${return_value}=  Set Variable  ${raw_value.split('(')[1].replace(')','')}
  [return]  ${return_value}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Switch browser   ${username}
  ${title}=  etender.Отримати інформацію із документа  ${username}  ${tender_uaid}  ${doc_id}  title
  ${prepared_locator}=  Set Variable  ${locator_document_href.replace('XX_doc_id_XX','${doc_id}')}
  log  ${prepared_locator}
  ${href}=  Get Element Attribute  ${prepared_locator}
  ${document_file}=  download_file_from_url  ${href}  ${OUTPUT_DIR}${/}${title}
  [return]  ${document_file}
