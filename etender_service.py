# -*- coding: utf-8 -

from iso8601 import parse_date
import dateutil.parser
from datetime import datetime, date, time, timedelta
from pytz import timezone
import os


def get_all_etender_dates(initial_tender_data, key, subkey=None):
    tender_period = initial_tender_data.data.auctionPeriod
    start_dt = dateutil.parser.parse(tender_period['startDate'])
    data = {
        'StartDate': {
            'date': start_dt.strftime("%d-%m-%Y"),
            'time': start_dt.strftime("%H:%M"),
        },
    }
    dt = data.get(key, {})
    return dt.get(subkey) if subkey else dt

def add_timezone_to_date(date_str):
    new_date = datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")
    TZ = timezone(os.environ['TZ'] if 'TZ' in os.environ else 'Europe/Kiev')
    new_date_timezone = TZ.localize(new_date)
    return new_date_timezone.strftime("%Y-%m-%d %H:%M:%S%z")

def convert_etender_date_to_iso_format(date_time_from_ui):
    new_timedata = datetime.strptime(date_time_from_ui, '%d-%m-%Y, %H:%M')
    new_date_time_string = new_timedata.strftime("%Y-%m-%d %H:%M:%S.%f")
    return new_date_time_string

def convert_dgfDecisionDateOut_to_etender_format(date_str):
    timedata = datetime.strptime(date_str, '%d.%m.%Y')
    stringdata = timedata.strftime("%Y-%m-%d")
    return stringdata

def convert_dgfDecisionDate_to_etender_format(date_str):
    timedata = datetime.strptime(date_str, '%Y-%m-%d')
    stringdata = timedata.strftime('%d-%m-%Y')
    return stringdata

def convert_date_to_etender_format(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%d-%m-%Y")
    return date_string

def convert_datetime_for_delivery(isodate):
    iso_dt = parse_date(isodate)
    date_string = iso_dt.strftime("%Y-%m-%d %H:%M")
    return date_string

def convert_time_to_etender_format(isodate):
    iso_dt = parse_date(isodate)
    time_string = iso_dt.strftime("%H:%M")
    return time_string

def convert_contractPeriod_date_from_etender_format_to_isoformat(contractPeriod_date):
    tmp_date = datetime.strptime(contractPeriod_date, '%d-%m-%Y')
    TZ = timezone(os.environ['TZ'] if 'TZ' in os.environ else 'Europe/Kiev')
    date_with_timezone_and_shift = TZ.localize(tmp_date)
    time_string = date_with_timezone_and_shift.isoformat()
    return time_string

def string_to_float(string):
    return float(string)

def float_to_string(float):
    return str(float)

def int_to_string(int):
    return str(int)

def float_to_string_2f(value):
    return '{:.2f}'.format(value)

def adapt_data(initial_data):
    initial_data['data']['procuringEntity']['name'] = u"Likvidator3"
    for cur_item in initial_data['data']['items']:
        old_date = cur_item['contractPeriod']['endDate']
        new_date = (parse_date(old_date) + timedelta(days=1)).isoformat()
        cur_item['contractPeriod']['endDate'] = new_date
    return initial_data

def convert_etender_string_to_common_string(string):
    dict = get_helper_dictionary()
    return dict.get(string, string)

def convert_common_string_to_etender_string(string):
    dict = get_helper_dictionary()
    for key, val in dict.iteritems():
        if val == string:
            return key
    return string

def get_helper_dictionary():
    return {
        u"ящ.": u"ящик",
        u"Гкал": u"Гігакалорія",
        u"посл.": u"послуга",
        u"роб.": u"роботи",
        u"шт.": u"штуки",
        u"га.": u"гектар",
        u"кг.": u"кілограми",
        u"км": u"кілометри",
        u"комп.": u"комплект",
        u"кВт⋅год": u"Кіловат-година",
        u"пог.м.": u"Погонний метр",
        u"л.": u"літр",
        u"м.кв.": u"метри квадратні",
        u"м.куб.": u"метри кубічні",
        u"м": u"метри",
        u"пач.": u"пачок",
        u"упак.": u"упаковка",
        u"пар.": u"пара",
        u"т.м.куб": u"тисяча кубічних метрів",
        u"наб.": u"набір",
        u"т.": u"тони",

        u"Очікування пропозицій":   u"active.tendering",
        u"Період аукціону":         u"active.auction",
        u"Кваліфікація переможця":  u"active.qualification",
        u"Кандидат розглядається":  u"active.qualification",
        u"Пропозиції розглянуто":   u"active.awarded",
        u"Переможця визначено":     u"active.awarded",
        u"Оплачено, очікується підписання договору": u"active.awarded",
        u"Закупівля не відбулась":  u"unsuccessful",
        u"Аукціон не відбувся":     u"unsuccessful",
        u"Торги не відбулись":      u"unsuccessful",
        u"Торги не відбулися":      u"unsuccessful",
        u"Відмінена закупівля":     u"cancelled",
        u"Відмінений аукціон":      u"cancelled",
        u"Торги відмінено":         u"cancelled",
        u"Завершена закупівля":     u"complete",
        u"Завершений аукціон":      u"complete",
        u"cancellation.status=Торги не відбулися": u"active", # workaround to distinguish between auction and cancellation
        u"Договір опубліковано": u"active", # contract status
        u"Протокол торгів": u"auctionProtocol", # document type
        u"Ліцензія": u"financialLicense", # document type

        u"Київська область": u"місто Київ", # document type

        u"(Оголошення аукціону з продажу прав вимоги за кредитами.)": u"dgfFinancialAssets",
        u"(Оголошення аукціону з продажу майна банків.)": u"dgfOtherAssets",
        u"(Оголошення аукціону з продажу майна.)": u"dgfOtherAssets",
        u"(Оголошення аукціону з Оренди.)": u"dgfOtherAssets",
        u"Код відповідного класифікатору лоту - CAV:": u"CAV",

        u"Посилання на Публічний Паспорт Активу":                   u"x_dgfPublicAssetCertificate",
        u"Публічний Паспорт Активу":                                u"technicalSpecifications",
        u"Virtual Data Room":                                       u"virtualDataRoom",
        u"Презентація":                                             u"x_presentation",
        u"Паспорт торгів":                                          u"tenderNotice",
        u"Договір NDA":                                             u"x_nda",
        u"Порядок ознайомлення з майном/активом у кімнаті даних":   u"x_dgfAssetFamiliarization",
        u"Місце та форма прийому заяв та банківськіх реквізитів":   u"x_dgfPlatformLegalDetails",
        u"Іллюстрації":                                             u"illustration",
        u"Інші": u"None",

    }

def convert_unit_name_to_unit_code(string):
    return {
        u"ящик": u"BX",
        u"блок": u"D64",
        u"Гігакалорія": u"E11",
        u"послуга": u"E48",
        u"роботи": u"E51",
        u"рейс": u"E54",
        u"штуки": u"H87",
        u"гектар": u"HAR",
        u"кілограми": u"KGM",
        u"кілометри": u"KMT",
        u"комплект": u"KT",
        u"Кіловат-година": u"KWH",
        u"Погонний метр": u"LM",
        u"лот": u"LO",
        u"літр": u"LTR",
        u"місяць": u"MON",
        u"метри квадратні": u"MTK",
        u"метри кубічні": u"MTQ",
        u"метри": u"MTR",
        u"пачок": u"NMP",
        u"упаковка": u"PK",
        u"пара": u"PR",
        u"тисяча кубічних метрів": u"R9",
        u"пачка": u"RM",
        u"набір": u"SET",
        u"тони": u"TNE",
    }.get(string, string)