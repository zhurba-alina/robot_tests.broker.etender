*** Settings ***
Library  String
Library  DateTime
Library  etender_service.py

*** Variables ***
${locator.auctionID}                                           id=tenderidua
${locator.title}                                               jquery=tender-subject-info>div.row:contains('Загальний опис процедури:')>:eq(1)>
${locator.description}                                         id=descriptionOut
${locator.minimalStep.amount}                                  xpath=//div[@class = 'row']/div/p[text() = 'Мінімальний крок аукціону:']/parent::div/following-sibling::div/p
${locator.procuringEntity.name}                                jquery=customer-info>div.row:contains("Найменування:")>:eq(1)>
${locator.value.amount}                                        id=lotvalue_0
${locator.proposition.value.amount}                            xpath=//div/input[@ng-model='bid.value.amount']
${locator.button.updateBid}                                    xpath=//button[@click-and-block='updateBid(bid)']
${locator.button.selectDocTypeForDoc}                          xpath=//select[@name='docType' and @id='docType' and @ng-model='selectedDocType' and @ng-change='docTypeSelectHundler()']
${locator.button.selectDocTypeForIll}                          xpath=(//tender-documents//*[@id='docType' and @ng-change='docTypeSelectHundler()'])
${locator.button.selectDocTypeForLicence}                      id=selectDoctype2
${locator.button.selectDocTypeForProtocol}                     id=selectDoctype1
${locator.button.addProtocol}                                  id=addNewDocToExistingBid2_0
${locator.button.addDoc}                                       id=tend_doc_add
${locator.dgfID}                                               xpath=//div[@class = 'row']/div/p[text() = 'Номер лоту в ФГВ:']/parent::div/following-sibling::div/p  # на сторінці перегляду
${locator.tenderPeriod.endDate}                                xpath=//div[@class = 'row']/div/p[text() = 'Завершення прийому пропозицій:']/parent::div/following-sibling::div/p
${locator.auctionPeriod.startDate}                             xpath=//span[@ng-if='lot.auctionPeriod.startDate']
${locator_item_description}                                    xpath=//div[@class = 'row']/div/p[text() = 'Опис активу:']/parent::div/following-sibling::div/p  #id=x25
${locator.items[0].description}                                id=style-desc-stuf-id0
${locator.items[1].description}                                id=style-desc-stuf-id1
${locator.items[2].description}                                id=style-desc-stuf-id2
${locator.items[0].deliveryDate.endDate}                       xpath=(//div[@class = 'col-sm-8']/p[@class='ng-binding'])[14]
${locator.items[0].deliveryLocation.latitude}                  id=delivery_latitude0
${locator.items[0].deliveryLocation.longitude}                 id=delivery_longitude0
${locator.items[0].deliveryAddress.postalCode}                 id=delivery_postIndex_0
${locator.items[0].deliveryAddress.countryName}                id=delivery_country_0
${locator.items[0].deliveryAddress.region}                     id=delivery_region_0
${locator.items[0].deliveryAddress.locality}                   xpath=//div[@class='col-sm-8']//span[@ng-if='item.deliveryAddress.city.title']
${locator.items[0].deliveryAddress.streetAddress}              xpath=//div[@class='col-sm-8']//span[@ng-if='item.deliveryAddress.addressStr']
${locator.items[0].classification.scheme}                      xpath=//div//*[@id='item_classification0']/../../..//p[contains( text(),'Код відповідного класифікатору лоту - CAV:')]
${locator.items[1].classification.scheme}                      xpath=//div//*[@id='item_classification1']/../../..//p[contains( text(),'Код відповідного класифікатору лоту - CAV:')]
${locator.items[2].classification.scheme}                      xpath=//div//*[@id='item_classification2']/../../..//p[contains( text(),'Код відповідного класифікатору лоту - CAV:')]
${locator.items[0].classification.id}                          id=item_classification0
${locator.items[1].classification.id}                          id=item_classification1
${locator.items[2].classification.id}                          id=item_classification2
${locator.items[0].classification.description}                 id=item_class_descr0
${locator.items[1].classification.description}                 id=item_class_descr1
${locator.items[2].classification.description}                 id=item_class_descr2
${locator_item_classification.description}                     id=item_class_descr0
${locator_item_classification.scheme}                          xpath=//div[@ng-repeat='item in lot.items']//p[contains(text(),'Класифікатор')]
${locator.items[0].additionalClassifications[0].scheme}        xpath=//div[6]/div[3]/div/p
${locator.items[0].additionalClassifications[0].id}            id=additionalClassification_id0
${locator.items[0].additionalClassifications[0].description}   id=additionalClassification_desc0
${locator.items[0].unit.code}                                  id=item_unit_symb0
${locator.items[1].unit.code}                                  id=item_unit_symb1
${locator.items[2].unit.code}                                  id=item_unit_symb2
${locator_item_unit.code}                                      id=item_unit_symb0
${locator.items[0].quantity}                                   id=item_quantity0
${locator.items[1].quantity}                                   id=item_quantity1
${locator.items[2].quantity}                                   id=item_quantity2
${locator.questions[0].title}                                  id=quest_title_0
${locator.questions[0].description}                            id=quest_descr_0
${locator.questions[0].date}                                   id=quest_date_0
${locator.questions[0].answer}                                 id=question_answer_0
${locator_question_item}                                       xpath=//select[@ng-model='vm.question.item']
${locator.cancellations[0].status}                             xpath=//div[contains(@ng-if,'detailes.cancellations')]//p[text()='Статус']/parent::div/following-sibling::div/p
${locator.cancellations[0].reason}                             xpath=//div[contains(@ng-if,'detailes.cancellations')]//p[text()='Причина:']/parent::div/following-sibling::div/p
${locator.contracts[-1].status}                                xpath=//div[@ng-if='isShowContract(award)']//p[text()='Статус договору:']/parent::div/following-sibling::div/p
${locator.value.currency}                                      xpath=//span[@id='lotvalue_0']/parent::p
${locator.value.valueAddedTaxIncluded}                         xpath=//span[@id='lotvalue_0']/following-sibling::i
${locator.items[0].unit.name}                                  id=item_unit_symb0
${locator.items[1].unit.name}                                  id=item_unit_symb1
${locator.items[2].unit.name}                                  id=item_unit_symb2
${locator.bids}                                                id=ParticipiantInfo_0
${locator.bids_0_amount}                                       xpath=(//form[@name='changeBidForm']//div[@class = 'row']/div/p[text() = 'Cума:']/parent::div/following-sibling::div/div/div/span)[1]  #note: mixed en/ru chars!
${locator.status}                                              xpath=//p[text() = 'Статус:']/parent::div/following-sibling::div/p
${huge_timeout_for_visibility}  300
${grid_page_text}                                              ProZorro.продажі
${locator.eligibilityCriteria}                                 xpath=//div[@class = 'row']/div/p[text() = 'Критерії прийнятності:']/parent::div/following-sibling::div/p
${locator.lot_items_unit}                                      id=itemsUnit0                    #Одиниця виміру
${locator_document_title}                                      xpath=//a[contains(text(),'XX_doc_id_XX')]
${locator_document_href}                                       xpath=(//a[contains(text(),'XX_doc_id_XX')])@href
${locator_document_description}                                xpath=//a[contains(text(),'XX_doc_id_XX')]
${locator_question_title}                                      xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]
${locator_question_description}                                xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]/ancestor::div[contains(@ng-repeat,'question in questions')]//span[contains(@id,'quest_descr_')]
${locator_question_answer}                                     xpath=//span[contains(@id,'quest_title_') and contains(text(),'XX_que_id_XX')]/ancestor::div[contains(@ng-repeat,'question in questions')]//pre[contains(@id,'question_answer_')]
${locator_dgfID}                                               id=dgfID  # на сторінці створення
${locator_start_auction_creation}                              xpath=//a[contains(@class, 'btn btn-info') and @data-target='#procedureType']  # на сторінці створення
${locator_block_overlay}                                       xpath=//div[@class='blockUI blockOverlay']
${locator_auction_search_field}                                xpath=//input[@type='text' and @placeholder='Пошук за номером аукціону']
${actives_counter_of_lot}                                      xpath=//div[@class = 'row']/div/p[text() = 'Загальна кількість активів лоту:']/parent::div/following-sibling::div/p
${locator_tender_attempts}                                     id=tenderAttempts
${locator.dgfDecisionDate}                                     id=dgfDecisionDateOut
${locator.dgfDecisionID}                                       id=dgfDecisionIdOut
${locator_dgfDecisionIDCreate}                                 id=dgfDecisionID
${dgfPublicAssetCertificateTitle}                              id=dgfPublicAssetCertificateTitle
${xdgfPublicAssetCertificateLinkId}                            id=xdgfPublicAssetCertificateLinkId
${locator.procurementMethodType}                               xpath=//span[@ng-show='getTenderProcedureType()']
${locator.dgfDecisionDate}                                     id=dgfDecisionDateId
${locator.dgfDecisionID}                                       id=dgfDecisionID_Id
${locator.tenderAttempts}                                      id=tenderAtempts

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
  ${start_date}=          get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          date
  ${start_time}=          get_all_etender_dates   ${ARGUMENTS[1]}         StartDate          time
  ${procurementMethodType}=     Get From Dictionary  ${ARGUMENTS[1].data}        procurementMethodType
  ${dgfDecisionID}=       Get From Dictionary        ${ARGUMENTS[1].data}        dgfDecisionID
  ${dgfDecisionDate}=     Get From Dictionary        ${ARGUMENTS[1].data}        dgfDecisionDate
  ${tenderAttempts}=      Get From Dictionary        ${ARGUMENTS[1].data}        tenderAttempts
  ${method_type}=         Get From Dictionary     ${ARGUMENTS[1].data}           procurementMethodType
  ${number_of_items}=     Get Length              ${items}

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
  Wait Until Element Is Visible      id=selectProcType1                      30
  Run Keyword If  '${method_type}' == 'dgfFinancialAssets'  Select From List By Value          id=selectProcType1    dgfFinancialAssets
  ...  ELSE IF    '${method_type}' == 'dgfOtherAssets'      Select From List By Value          id=selectProcType1    dgfOtherAssets
  Wait Until Element Is Visible      id=goToCreate
  Click Element                      id=goToCreate
  Wait Until Element Is Visible      id=title
  Input text                         id=title                                            ${title}
  Wait Until Element Is Visible      id=description
  Input text                         id=description                                      ${description}
  Wait Until Element Is Visible      ${locator_tender_attempts}                          30
  ${tenderAttempts_string}=          int_to_string                                       ${tenderAttempts}
  Select From List By Label          ${locator_tender_attempts}                          ${tenderAttempts_string}
  Wait Until Page Contains Element   xpath=//input[@id="auctionPeriod_startDate_day"]
  Input text                         xpath=//input[@id="auctionPeriod_startDate_day"]    ${start_date}
  Wait Until Page Contains Element   xpath=//input[@id="dgfDecisionDate"]
  ${dgfDecisionDate_etender}=        convert_dgfDecisionDate_to_etender_format           ${dgfDecisionDate}
  Input text                         xpath=//input[@id="dgfDecisionDate"]                ${dgfDecisionDate_etender}
  Wait Until Page Contains Element   xpath=//input[@id="auctionPeriod_startDate_time"]
  Input text                         xpath=//input[@id="auctionPeriod_startDate_time"]   ${start_time}
  Wait Until Element Is Visible      id=lotValue_0
  Input text                         id=lotValue_0                                       ${budgetToStr}
  Wait Until Element Is Visible      xpath=(//*[@id='valueAddedTaxIncluded'])[2]
  Click Element                      xpath=(//*[@id='valueAddedTaxIncluded'])[2]
  Wait Until Element Is Visible      id=minimalStep_0
  Input text                         id=minimalStep_0                                    ${step_rateToStr}
  Wait Until Element Is Visible      id=inputGuarantee
  Input text                         id=inputGuarantee                                   ${lotGuaranteeToStr}
  Wait Until Element Is Visible      ${locator_dgfID}
  Input text                         ${locator_dgfID}                                    ${dgfID}
  log to console                     ${dgfDecisionID}
  Wait Until Element Is Visible      ${locator_dgfDecisionIDCreate}
  Input text                         ${locator_dgfDecisionIDCreate}                      ${dgfDecisionID}
  log to console                     ${dgfDecisionDate}
  :FOR  ${index}  IN RANGE  ${number_of_items}
  \  Run Keyword If  ${index} != 0  Click Element  id=addLotItem_${index -1}
  \  Додати актив лоту  ${items[${index}]}  ${index}
  Wait Until Element Is Visible      id=CreateTenderE
  Click Element                      id=CreateTenderE
  Wait Until Page Contains           Закупівлю створено!             60
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
  Focus                                     ${locator.button.selectDocTypeForDoc}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForDoc}
  Click Element                             ${locator.button.selectDocTypeForDoc}
  Select From List By Label                 ${locator.button.selectDocTypeForDoc}    Інші
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File                               ${locator.button.addDoc}                 ${ARGUMENTS[1]}
  Wait Until Page Contains                  Файл додано!                             60

Завантажити ілюстрацію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForIll}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForIll}
  Click Element                             ${locator.button.selectDocTypeForIll}
  Select From List By Label                 ${locator.button.selectDocTypeForIll}    Ілюстрації
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File	                            ${locator.button.addDoc}                 ${filepath}
  Wait Until Page Contains                  Файл додано!                             60

Завантажити фінансову ліцензію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForLicence}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForLicence}
  Click Element                             ${locator.button.selectDocTypeForLicence}
  Select From List By Label                 ${locator.button.selectDocTypeForLicence}        Ліцензія
  Wait Until Element Is Visible             xpath=(//*[@id='addNewDocToExistingBid_0'][1])
  Choose File	                            xpath=(//*[@id='addNewDocToExistingBid_0'][1])   ${filepath}
  Wait Until Page Contains                  Файл додано!                                     60

Завантажити протокол аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
  etender.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForProtocol}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForProtocol}
  Click Element                             ${locator.button.selectDocTypeForProtocol}
  Select From List By Label                 ${locator.button.selectDocTypeForProtocol}       Протокол торгів
  Wait Until Element Is Visible             ${locator.button.addProtocol}
  Choose File	                            ${locator.button.addProtocol}                    ${filepath}
  Wait Until Page Contains                  Файл додано!                                     60

Додати Virtual Data Room
  [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}  ${title}=Sample Virtual Data Room
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible            id=title                                      60
  Input Text                               id=title                                      ${title}
  Wait Until Element Is Visible            xpath=//virtual-data-room//*[@id='url']        60
  Input Text                               xpath=//virtual-data-room//*[@id='url']      ${vdr_url}
  Wait Until Element Is Visible            xpath=//virtual-data-room//*[contains(text(),'Зберегти зміни')]
  Click Element                            xpath=//virtual-data-room//*[contains(text(),'Зберегти зміни')]
  Wait Until Page Contains                 VDR збережено!                                60

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

Додати актив лоту
  [Arguments]  ${item}  ${index}
  ${items_description}=   Get From Dictionary     ${item}                           description
  ${quantity}=            Get From Dictionary     ${item}                           quantity
  ${cav}=                 Get From Dictionary     ${item.classification}            id
  ${unit}=                Get From Dictionary     ${item.unit}                      name
  ${latitude}=            Get From Dictionary     ${item.deliveryLocation}          latitude
  ${longitude}=           Get From Dictionary     ${item.deliveryLocation}          longitude
  ${postalCode}=          Get From Dictionary     ${item.deliveryAddress}           postalCode
  ${streetAddress}=       Get From Dictionary     ${item.deliveryAddress}           streetAddress
  ${deliveryDate}=        Get From Dictionary     ${item.deliveryDate}              endDate
  ${deliveryDate}=        convert_date_to_etender_format        ${deliveryDate}
  Wait Until Element Is Visible      id=itemsDescription${index}
  Input text                         id=itemsDescription${index}                    ${items_description}
  Wait Until Element Is Visible      id=itemsQuantity${index}
  Input text                         id=itemsQuantity${index}                       ${quantity}
  ${unit_etender}=                   convert_common_string_to_etender_string        ${unit}
  Select From List By Label          id=itemsUnit${index}                           ${unit_etender}
  Wait Until Element Is Visible      xpath=(//input[@id='openClassificationModal'])[${index +1}]
  Click Element                      xpath=(//input[@id='openClassificationModal'])[${index +1}]
  Wait Until Element Is Visible      xpath=//div[contains(@class, 'modal-content')]//input[@ng-model='searchstring']
  Input text                         xpath=//div[contains(@class, 'modal-content')]//input[@ng-model='searchstring']  ${cav}
  Wait Until Element Is Visible      xpath=//td[contains(., '${cav}')]
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Click Element                      xpath=//td[contains(., '${cav}')]
  Wait Until Element Is Visible      xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]
  Click Element                      xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]

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
  [Arguments]  ${username}  ${tender_uaid}  ${bid}
  ${amount}=    Get From Dictionary     ${bid.data.value}         amount
  ${amount}=    float_to_string_2f      ${amount}
  Sleep  60
  etender.Пошук тендера по ідентифікатору   ${username}  ${tender_uaid}
  sleep  15
  ${status}	            ${value}=  Run Keyword And Ignore Error	  Get From Dictionary  ${bid.data}  qualified
  Run Keyword If	   '${status}' == 'PASS'  Подати цінову пропозицію без кваліфікації користувачем  ${amount}
  Run Keyword Unless   '${status}' == 'PASS'   Подати цінову пропозицію користувачем  ${amount}

Подати цінову пропозицію користувачем
  [Arguments]  ${amount}
  Wait Until Page Contains Element  xpath=//input[@name='amount0']          30
  Clear Element Text	            xpath=//input[@name='amount0']
  Input text                        xpath=//input[@name='amount0']          ${amount}
  Wait Until Element Is Enabled     xpath=(//button[@click-and-block='canBid(lot)'][contains(text(), 'Реєстрація пропозиції')])
  Click Element                     xpath=(//button[@click-and-block='canBid(lot)'][contains(text(), 'Реєстрація пропозиції')])
  Capture Page Screenshot
  Wait Until Page Contains          Пропозицію додано!                      30
  Sleep                             5
  Click Element                     xpath=//button[@click-and-block='activateBid(bid)']
  Log                               Button 'Підтвердити ставку' was created for Autotesting only
  Wait Until Page Contains          Пропозицію підтверджено!                30

Подати цінову пропозицію без кваліфікації користувачем
  [Arguments]  ${amount}
  Wait Until Page Contains Element  xpath=//input[@name='amount0']          30
  Input text                        xpath=//input[@name='amount0']          ${amount}
  Wait Until Element Is Enabled     xpath=(//button[contains(text(), 'Реєстрація пропозиції (автотест)')])
  Click Element                     xpath=(//button[contains(text(), 'Реєстрація пропозиції (автотест)')])
  Wait Until Page Contains          Ви ще не пройшли валідацію, щоб приймати участь у торгах.           30
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

Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${cancellation_reason}  ${document}  ${new_description}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=//span[contains(@ng-if,'detailes.cancellations') and text()='Почати процедуру скасування торгів']  ${huge_timeout_for_visibility}
  Click Element                  xpath=//span[contains(@ng-if,'detailes.cancellations') and text()='Почати процедуру скасування торгів']
  Wait Until Element Is Visible  xpath=//textarea[@placeholder='Причина']  ${huge_timeout_for_visibility}
  Sleep  2
  Input text                     xpath=//textarea[@placeholder='Причина']  ${cancellation_reason}
  Click Element                  xpath=//button[@ng-click='beginCancelTender()' and text()='Почати процедуру']
  Wait Until Page Contains Element  xpath=//form[@name='cancelForm']//input[@id='tend_doc_add']  ${huge_timeout_for_visibility}
  Sleep  1
  Choose File  xpath=//form[@name='cancelForm']//input[@id='tend_doc_add']  ${document}
  Sleep  1
  Run Keyword And Ignore Error   Page Should Contain  файл додано
  # TODO: remove sleep after file upload progressbar fix
  Sleep  120
  Wait Until Element Is Visible  xpath=//div[@id='modalCancelTender']//button[text()=' Зберегти зміни та продовжити пізніше']
  Click Element                  xpath=//div[@id='modalCancelTender']//button[text()=' Зберегти зміни та продовжити пізніше']
  Wait Until Keyword Succeeds  5 x  30  Продовжити процедуру скасування аукціона  ${username}  ${tender_uaid}

Продовжити процедуру скасування аукціона
  [Arguments]  ${username}  ${tender_uaid}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=//span[contains(@ng-if,'detailes.cancellations') and text()='Продовжити процедуру скасування аукціона']
  Click Element                  xpath=//span[contains(@ng-if,'detailes.cancellations') and text()='Продовжити процедуру скасування аукціона']
  Wait Until Element Is Visible  xpath=//button[@ng-click='endCancelTender()']  ${huge_timeout_for_visibility}  # Скасувати аукціон
  Click Element                  xpath=//button[@ng-click='endCancelTender()']  # Скасувати аукціон
  Wait Until Page Contains       Торги скасовано!

Оновити сторінку з тендером
  [Arguments]  @{ARGUMENTS}
  [Documentation]
  ...      ${ARGUMENTS[0]} =  username
  ...      ${ARGUMENTS[1]} =  ${TENDER_UAID}
  Selenium2Library.Switch Browser    ${ARGUMENTS[0]}
  etender.Пошук тендера по ідентифікатору    ${ARGUMENTS[0]}   ${ARGUMENTS[1]}
  Reload Page

Задати запитання на щось
  [Arguments]  ${username}  ${TENDER_UAID}  ${question_data}  ${question_to}  ${item_id}
  [Documentation]
  ${title}=        Get From Dictionary  ${question_data.data}  title
  ${description}=  Get From Dictionary  ${question_data.data}  description
  Selenium2Library.Switch Browser    ${username}
  etender.Пошук тендера по ідентифікатору   ${username}   ${TENDER_UAID}
  Execute Javascript   window.scrollTo(0, document.body.scrollHeight)
  Wait Until Element Is Visible      xpath=//a[contains(@href,'#/addQuestion/')]  ${huge_timeout_for_visibility}
  Sleep  1
  Click Element                      xpath=//a[contains(@href,'#/addQuestion/')]
  Wait Until Element Is Visible      id=title  ${huge_timeout_for_visibility}
  Sleep  1
  Input text                         id=title                 ${title}
  Input text                         id=description           ${description}
  Select From List By Label          xpath=//select[@ng-model='vm.questionTo']  ${question_to}
  Run Keyword If  'Предмет аукціону' == '${question_to}'  Вказати предмет для питання  ${item_id}
  Click Element                      xpath=//button[@type='submit']
  Wait Until Page Does Not Contain   xpath=//button[@type='submit']  ${huge_timeout_for_visibility}

Вказати предмет для питання
  [Arguments]  ${item_id}
  Wait Until Element Is Visible      ${locator_question_item}
  @{items}=  Get List Items          ${locator_question_item}
  Log  ${items}
  ${tmp_item}=  Set variable  stub
  :FOR  ${item_x}  IN  @{items}
  \  ${tmp_item}=  Set variable  ${item_x}
  \  ${item_was_found_by_prefix}=  Run Keyword And Return Status  Should Contain  ${tmp_item}  ${item_id}
  \  Run Keyword If  ${item_was_found_by_prefix}  Exit For Loop
  \  ${tmp_item}=  Set variable  stub2
  Log  ${tmp_item}
  Select From List By Label          ${locator_question_item}  ${tmp_item}

Задати запитання на предмет
  [Arguments]  ${username}  ${TENDER_UAID}  ${item_id}  ${question_data}
  etender.Задати запитання на щось  ${username}  ${TENDER_UAID}  ${question_data}  Предмет аукціону  ${item_id}

Задати запитання на тендер
  [Arguments]  ${username}  ${TENDER_UAID}  ${question_data}
  etender.Задати запитання на щось  ${username}  ${TENDER_UAID}  ${question_data}  Аукціону  nothing

Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${question_id}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Wait Until Element Is Visible      id=addAnswer_0  ${huge_timeout_for_visibility}
  Wait Until Element Is Enabled      id=addAnswer_0  ${huge_timeout_for_visibility}
  Click Element                      id=addAnswer_0
  Wait Until Element Is Visible      xpath=//*[@id="questionContainer"]/form/div/textarea            ${huge_timeout_for_visibility}
  Input text                         xpath=//*[@id="questionContainer"]/form/div/textarea            ${answer_data.data.answer}
  Wait Until Element Is Enabled      xpath=//*[@id="questionContainer"]/form/div/span/button[1]      ${huge_timeout_for_visibility}
  Click Element                      xpath=//*[@id="questionContainer"]/form/div/span/button[1]
  Wait Until Element Is Not Visible  xpath=//*[@id="questionContainer"]/form/div/span/button[1]      ${huge_timeout_for_visibility}

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
  ${passed} =	   Run Keyword And Return Status	Should Match Regexp    ${fieldname}      ^items\\\[
  Run Keyword And Return If  ${passed}==True	  Get Keyword From Items Index   ${fieldname}
  Run Keyword And Return  Отримати інформацію про ${fieldname}

Get Keyword From Items Index
  [Arguments]   ${fieldname}
  @{index_in_list}=  Get Regexp Matches	  ${fieldname}  items\\\[([\\\-\\\d]+)\\\]\\\.(.+)  1
  ${index}=  Set Variable  @{index_in_list}[0]
  @{item_in_list}=   Get Regexp Matches	  ${fieldname}  items\\\[([\\\-\\\d]+)\\\]\\\.(.+)  2
  ${item}=  Set Variable  @{item_in_list}[0]
  Run Keyword And Return   Отримати інформацію про items.${item}   ${index}

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

Отримати інформацію про items.deliveryLocation.latitude
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].deliveryLocation.latitude
  ${return_value}=   string_to_float   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items.deliveryLocation.longitude
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].deliveryLocation.longitude
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


Отримати інформацію про items.unit.name
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[${index}].unit.name
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

Отримати інформацію про items.description
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[${index}].description
  [return]  ${return_value}

Отримати інформацію про items.unit.code
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[${index}].unit.code
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  ${return_value}=   convert_unit_name_to_unit_code  ${return_value}
  [return]  ${return_value}

Отримати інформацію про items.quantity
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці   items[${index}].quantity
  ${return_value}=   Convert To Number   ${return_value}
  [return]  ${return_value}

Отримати інформацію про items.classification.id
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].classification.id
  [return]  ${return_value}

Отримати інформацію про items.classification.scheme
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].classification.scheme
  ${return_value}=   convert_etender_string_to_common_string      ${return_value}
  [return]           ${return_value}

Отримати інформацію про items.classification.description
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].classification.description
  Run Keyword And Return  convert_etender_string_to_common_string  ${return_value}

Отримати інформацію про items.additionalClassifications[0].id
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].additionalClassifications[0].id
  [return]  ${return_value.split(' ')[0]}

Отримати інформацію про items.additionalClassifications[0].scheme
  [Arguments]  ${index}
  ${return_value}=   Отримати текст із поля і показати на сторінці  items[${index}].additionalClassifications[0].scheme
  ${return_value}=   Get Substring  ${return_value}   0   -1
  [return]  ${return_value.split(' ')[1]}

Отримати інформацію про items.additionalClassifications[0].description
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].additionalClassifications[0].description
  [return]  ${return_value}

Отримати інформацію про items.deliveryAddress.postalCode
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].deliveryAddress.postalCode
  Run Keyword And Return  Get Substring  ${return_value}  0  5

Отримати інформацію про items.deliveryAddress.countryName
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].deliveryAddress.countryName
  Run Keyword And Return  Get Substring  ${return_value}  0  7

Отримати інформацію про items.deliveryAddress.region
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].deliveryAddress.region
  ${return_value}=    convert_etender_string_to_common_string     ${return_value}
  [return]  ${return_value}

Отримати інформацію про items.deliveryAddress.locality
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].deliveryAddress.locality
  ${return_value}=   Remove String      ${return_value}     ,
  ${return_value}=    convert_etender_string_to_common_string     ${return_value}
  [return]  ${return_value}

Отримати інформацію про items.deliveryAddress.streetAddress
  [Arguments]  ${index}
  Run Keyword And Return  Отримати текст із поля і показати на сторінці  items[${index}].deliveryAddress.streetAddress

Отримати інформацію про items.deliveryDate.endDate
  [Arguments]  ${index}
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].deliveryDate.endDate
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

Отримати інформацію про cancellations[0].status
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  ${status}=  Отримати текст із поля і показати на сторінці  cancellations[0].status
  ${return_value}=   convert_etender_string_to_common_string  cancellation.status=${status}  # workaround to distinguish between auction and cancellation
  [return]  ${return_value}

Отримати інформацію про cancellations[0].reason
  ${return_value}=   Отримати текст із поля і показати на сторінці   cancellations[0].reason
  [return]    ${return_value}

Отримати інформацію про bids
  [Documentation]
  ...  Для перевірки можливості побачити цінові пропозиції учасників під час прийому пропозицій.
  ...  На даний момет важливим є лише те, виконається кейворд успішно чи видасть помилку. Значення не перевіряється
  ${return_value}=   Отримати текст із поля і показати на сторінці   bids_0_amount
  [return]    ${return_value}

Отримати інформацію про contracts[-1].status
  ${return_value}=   Отримати текст із поля і показати на сторінці   contracts[-1].status
  ${return_value}=   convert_etender_string_to_common_string   ${return_value}
  [return]    ${return_value}

Отримати інформацію про procurementMethodType
  ${return_value}=   Отримати текст із поля і показати на сторінці   procurementMethodType
  ${return_value}=   convert_etender_string_to_common_string   ${return_value}
  [return]           ${return_value}

Отримати інформацію про dgfDecisionDate
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfDecisionDate
  log                ${return_value}
  ${return_value}=   convert_dgfDecisionDateOut_to_etender_format   ${return_value}
  log                ${return_value}
  [return]           ${return_value}

Отримати інформацію про dgfDecisionID
  ${return_value}=   Отримати текст із поля і показати на сторінці   dgfDecisionID
  log                ${return_value}
  ${return_value}=   convert_etender_string_to_common_string   ${return_value}
  log                ${return_value}
  [return]           ${return_value}

Отримати інформацію про tenderAttempts
  ${return_value}=   Отримати текст із поля і показати на сторінці   tenderAttempts
  log                ${return_value}
  ${return_value}=   Convert To Integer   ${return_value}
  log                ${return_value}
  [return]           ${return_value}

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

Отримати кількість документів в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}
  Switch browser   ${username}
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  ${bid_index}=  Convert To Integer  ${bid_index}
  ${prepared_locator}=  Run Keyword IF  ${bid_index} < 0   Set Variable  (//div[@ng-repeat='bid in lot.bids'])[last()+1${bid_index}]//div[@ng-show='!document.isDeleted']
  ...  ELSE  Set Variable  (//div[@ng-repeat='bid in lot.bids'])[1+${bid_index}]//div[@ng-show='!document.isDeleted']
  ${return_value}=  Get Matching Xpath Count  ${prepared_locator}
  ${return_value}=  Convert To Integer  ${return_value}
  [return]  ${return_value}

Конвертувати інформацію із документа про title
  [Arguments]  ${raw_value}
  ${return_value}=  Set Variable  ${raw_value.split(',')[0]}
  [return]  ${return_value}

Конвертувати інформацію із документа про description
  [Arguments]  ${raw_value}
  [return]  ${raw_value}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Switch browser   ${username}
  ${title}=  etender.Отримати інформацію із документа  ${username}  ${tender_uaid}  ${doc_id}  title
  ${prepared_locator}=  Set Variable  ${locator_document_href.replace('XX_doc_id_XX','${doc_id}')}
  log  ${prepared_locator}
  ${href}=  Get Element Attribute  ${prepared_locator}
  ${document_file}=  download_file_from_url  ${href}  ${OUTPUT_DIR}${/}${title}
  [return]  ${document_file}

Отримати документ до скасування
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  Run Keyword And Return  etender.Отримати документ  ${username}  ${tender_uaid}  ${doc_id}

Отримати дані із документу пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}  ${document_index}  ${field}
  Switch browser   ${username}
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Run Keyword And Return  Отримати дані із документу пропозиції про ${field}  ${bid_index}  ${document_index}

Отримати дані із документу пропозиції про documentType
  [Arguments]  ${bid_index}  ${document_index}
  ${bid_index}=  Convert To Integer  ${bid_index}
  ${prepared_locator}=  Run Keyword IF  ${bid_index} < 0   Set Variable  xpath=((//div[@ng-repeat='bid in lot.bids'])[last()+1${bid_index}]//div[contains(@class,'label-info') and contains(text(),'Тип документа')])[1+${document_index}]
  ...  ELSE  Set Variable  xpath=((//div[@ng-repeat='bid in lot.bids'])[1+${bid_index}]//div[contains(@class,'label-info') and contains(text(),'Тип документа')])[1+${document_index}]
  ${raw_value}=   Get Text  ${prepared_locator}
  ${raw_value}=  Set Variable  ${raw_value.replace(u'Тип документа: ', u'')}
  ${return_value}=  convert_etender_string_to_common_string  ${raw_value}
  [return]  ${return_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field}
  Switch browser   ${username}
  Reload Page
  ${prepared_locator}=  Set Variable  ${locator_question_${field}.replace('XX_que_id_XX','${question_id}')}
  log  ${prepared_locator}
  Wait Until Page Contains Element  ${prepared_locator}  10
  Wait Until Keyword Succeeds  10 x  5  Check Is Element Loaded  ${prepared_locator}
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
  Wait Until Element Is Visible  xpath=//a[@data-target='#modalGetAwards']
  Click Element  xpath=//a[@data-target='#modalGetAwards']
  Wait Until Element Is Visible  xpath=//button[@ng-click='getAwardsNextStep()']
  Click Element  xpath=//button[@ng-click='getAwardsNextStep()']
  Wait Until Element Is Visible  xpath=//button[@click-and-block='setDecision(1)']
  Click Element  xpath=//button[@click-and-block='setDecision(1)']

Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
  log  ${username}
  log  ${tender_uaid}
  log  ${contract_num}
  log  ${filepath}
  sleep  5
  Capture Page Screenshot
  Click Element  id=btn_ContractActiveAwarded
  sleep  5
  Capture Page Screenshot
  Choose File  id=tend_doc_add  ${filepath}
  sleep  1
  sleep  240  #  wait till disappears "Поки не експортовано"
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Sleep  20
  Capture Page Screenshot
  ${href}=  Get Element Attribute  xpath=(//div[@ng-show='!document.isDeleted']/a)@href
  sleep  30
  [return]  ${href}

Підтвердити підписання контракту
  [Documentation]
  ...      [Arguments] Username, tender uaid, contract number
  ...      [Return] Nothing
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  sleep  10
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Capture Page Screenshot
  Wait Until Element Is Visible   id=btn_ContractActiveAwarded    60
  Click Element                   id=btn_ContractActiveAwarded
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

Скасування рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Capture Page Screenshot
  sleep  30
  Wait Until Element Is Visible  id=btn_modalCancelAward    30
  Click Element                  id=btn_modalCancelAward
  sleep  1
  Capture Page Screenshot
  Wait Until Element Is Visible  xpath=//textarea[@ng-model='cancelAwardModel.description']  30
  Input Text                     xpath=//textarea[@ng-model='cancelAwardModel.description']  Якась причина для скасування (для потреб автотестів)
  Select From List By Label      xpath=//select[@ng-model='vm.ca.causeTitles']  Відмовився від підписання договору
  Click Element                  xpath=//button[@ng-click='cancelAward()']

Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${document}  ${tender_uaid}  ${award_num}
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  Capture Page Screenshot
  sleep  30
  Wait Until Element Is Visible      id=btn_getAwardsId1      30
  Click Element                      id=btn_getAwardsId1
  sleep  1
  Wait Until Element Is Visible      id=documentToAdd4        30
  Choose File                        id=documentToAdd4        ${document}
  Wait Until Page Contains           Файл додано!             30
  Reload Page
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  sleep  30
  Capture Page Screenshot
  Wait Until Element Is Visible      id=btn_getAwardsId1      30
  Click Element                      id=btn_getAwardsId1
  sleep  3
  Wait Until Element Is Visible      id=btn_nextStepAwards    30
  Click Element                      id=btn_nextStepAwards
  sleep  3
  Wait Until Element Is Visible      id=btn_disqualify        30
  Click Element                      id=btn_disqualify
  Wait Until Page Contains           Кандидата відмінено!

Дискваліфікувати постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_num}  ${description}
  Log  Розібратись докладніше які дії в яких кейвордах мають бути
  No Operation

Отримати кількість предметів в тендері
  [Arguments]  ${username}  ${tender_uaid}
  Switch browser   ${username}
  Wait Until Page Does Not Contain   ${locator_block_overlay}
  ${actives_counter_of_lot_value}=   Get Text  ${actives_counter_of_lot}
  ${actives_counter_of_lot_value}=  Convert To Integer  ${actives_counter_of_lot_value}
  [return]  ${actives_counter_of_lot_value}

Додати предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  Run Keyword And Ignore Error  Спробувати додати предмет закупівлі  ${username}  ${tender_uaid}  ${item}


Спробувати додати предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  Wait Until Element Is Visible      id=addLotItem_0
  Click Element                      id=addLotItem_0
  Wait Until Element Is Visible      id=itemsDescription1
  Input text                         id=itemsDescription1                                ${items_description}
  Wait Until Element Is Visible      id=itemsQuantity1
  Input text                         id=itemsQuantity1                                   ${quantity}
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
  Click Element                      xpath=//div[@id='classification']//button[starts-with(@ng-click, 'choose(')]

Видалити предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
  Run Keyword And Ignore Error  Спробувати видалити предмет закупівлі   ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}

Спробувати видалити предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${lot_id}=${Empty}
  etender.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible       xpath=//button[@ng-click='vm.removeLotItem(lot, $index)']
  Click Element                       xpath=//button[@ng-click='vm.removeLotItem(lot, $index)']

Додати публічний паспорт активу
  [Arguments]  ${username}  ${tender_uaid}  ${certificate_url}  ${title}=Public Asset Certificate
  Wait Until Element Is Visible       ${dgfPublicAssetCertificateTitle}
  Sleep   10
  Input text                          ${dgfPublicAssetCertificateTitle}                     test
  Wait Until Element Is Visible       ${xdgfPublicAssetCertificateLinkId}
  Sleep   10
  Input text                          ${xdgfPublicAssetCertificateLinkId}                   http://test.com
  Sleep   10
  Wait Until Element Is Visible       xpath=//a[@click-and-block='savexdgfPublicAssetCertificate()']      60
  Click Element                       xpath=//a[@click-and-block='savexdgfPublicAssetCertificate()']
  Wait Until Page Contains            Посилання на Публічний Паспорт Активу збережено!

Завантажити документ в тендер з типом
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${documentType}
  log  ${documentType}
  Run Keyword  Завантажити ${documentType}      ${username}  ${tender_uaid}  ${filepath}

Завантажити x_presentation
    [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForIll}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForIll}
  Click Element                             ${locator.button.selectDocTypeForIll}
  Select From List By Label                 ${locator.button.selectDocTypeForIll}    Презентація
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File	                            ${locator.button.addDoc}                 ${filepath}
  Wait Until Page Contains                  Файл додано!                             60

Завантажити tenderNotice
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForIll}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForIll}
  Click Element                             ${locator.button.selectDocTypeForIll}
  Select From List By Label                 ${locator.button.selectDocTypeForIll}    Паспорт торгів
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File	                            ${locator.button.addDoc}                 ${filepath}
  Wait Until Page Contains                  Файл додано!                             60

Завантажити x_nda
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForIll}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForIll}
  Click Element                             ${locator.button.selectDocTypeForIll}
  Select From List By Label                 ${locator.button.selectDocTypeForIll}    Договір NDA
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File	                            ${locator.button.addDoc}                 ${filepath}
  Wait Until Page Contains                  Файл додано!                             60

Завантажити technicalSpecifications
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  etender.Пошук тендера по ідентифікатору   ${username}   ${tender_uaid}
  Focus                                     ${locator.button.selectDocTypeForIll}
  Wait Until Page Contains Element          ${locator.button.selectDocTypeForIll}
  Click Element                             ${locator.button.selectDocTypeForIll}
  Select From List By Label                 ${locator.button.selectDocTypeForIll}    Публічний Паспорт Активу
  Wait Until Element Is Visible             ${locator.button.addDoc}
  Choose File	                            ${locator.button.addDoc}                 ${filepath}
  Wait Until Page Contains                  Файл додано!                             60

Додати офлайн документ
  [Arguments]  ${username}  ${tender_uaid}  ${accessDetails}  ${title}=Familiarization with bank asset
  Wait Until Page Contains Element               id=accessDetails                                 60
  Sleep  10
  Input text                                     id=accessDetails                                 test
  Wait Until Element Is Visible                  xpath=//a[@click-and-block='saveVdr()']          60
  Click Element                                  xpath=//a[@click-and-block='saveVdr()']
  Wait Until Page Contains            Порядку ознайомлення збережено!


