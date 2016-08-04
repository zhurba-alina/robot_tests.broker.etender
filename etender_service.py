# -*- coding: utf-8 -

from iso8601 import parse_date
import dateutil.parser
from datetime import datetime, date, time


def get_all_etender_dates(initial_tender_data, key, subkey=None):
    tender_period = initial_tender_data.data.tenderPeriod
    enquiry_period = initial_tender_data.data.enquiryPeriod
    end_period = dateutil.parser.parse(enquiry_period['endDate'])
    start_dt = dateutil.parser.parse(tender_period['startDate'])
    end_dt = dateutil.parser.parse(tender_period['endDate'])
    data = {
        'EndPeriod': {
            'date': end_period.strftime("%d-%m-%Y"),
            'time': end_period.strftime("%H:%M"),
        },
        'StartDate': {
            'date': start_dt.strftime("%d-%m-%Y"),
            'time': start_dt.strftime("%H:%M"),
        },
        'EndDate': {
            'date': end_dt.strftime("%d-%m-%Y"),
            'time': end_dt.strftime("%H:%M"),
        },
    }
    dt = data.get(key, {})
    return dt.get(subkey) if subkey else dt


def convert_etender_date_to_iso_format(date_time_from_ui):
    new_timedata = datetime.strptime(date_time_from_ui, '%d-%m-%Y, %H:%M')
    new_date_time_string = new_timedata.strftime("%Y-%m-%d %H:%M:%S.%f")
    return new_date_time_string


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


def string_to_float(string):
    return float(string)


def adapt_data(initial_data):
    initial_data['data']['procuringEntity']['name'] = u"ПП ГО Організатор X"
    return initial_data


def convert_etender_string_to_common_string(string):
    return {
        u"Київська область": u"м. Київ",
        u"Київ": u"м. Київ",
        u"кг.": u"кілограми",
        u"грн.": u"UAH",
        u"(включаючи ПДВ)": True,
        u"Період уточнень":         u"active.enquiries",
        u"Очікування пропозицій":   u"active.tendering",
        u"Період аукціону":         u"active.auction",
        u"Кваліфікація переможця":  u"active.qualification",
        u"Пропозиції розглянуто":   u"active.awarded",
        u"Закупівля не відбулась":  u"unsuccessfull",
        u"Відмінена закупівля":     u"cancelled",
        u"Завершена закупівля":     u"complete",
    }.get(string, string)
