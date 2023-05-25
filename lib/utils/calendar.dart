import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../styles/ColorResources.dart';

final calendarConfig = CalendarDatePicker2Config(
  calendarType: CalendarDatePicker2Type.range,
  selectedDayHighlightColor: ColorResources.accentRed,
  weekdayLabels: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
  weekdayLabelTextStyle: const TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  ),
  firstDayOfWeek: 1,
  controlsHeight: 50,
  controlsTextStyle: const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
  dayTextStyle: const TextStyle(
    color: ColorResources.accentRed,
    fontWeight: FontWeight.normal,
  ),
  disabledDayTextStyle: const TextStyle(
    color: Colors.grey,
  ),
  selectableDayPredicate: (day) => true,
);