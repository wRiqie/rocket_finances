import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  AppHelpers._();

  static final _months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  static String getMonthName(int month) {
    return _months[month - 1];
  }

  static String getWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'Sex';
      case 6:
        return 'Sab';
      default:
        return 'Dom';
    }
  }

  static String formatDayMonthYear(DateTime? dateTime) {
    if (dateTime == null) return '';

    var format = DateFormat('dd/MM/yyyy');
    return format.format(dateTime);
  }

  static String formatCompleteBrDay(DateTime? dateTime) {
    if (dateTime == null) return '';

    var format = DateFormat("dd/MM/yyyy 'às' HH:mm");
    return format.format(dateTime);
  }

  static String formatDayMonth(DateTime? dateTime) {
    if (dateTime == null) return '';

    var format = DateFormat('dd/MM');
    return format.format(dateTime);
  }

  /// Formata o [number] para moeda
  static String formatCurrency(num? number, {String currencyLocale = 'pt_BR'}) {
    if (number == null) return '';
    // Define uma expressão regular para encontrar espaços duros (&nbsp;).
    RegExp regexErrorSpace = RegExp(r'\u00a0');

    var formated =
        NumberFormat.simpleCurrency(locale: Locale(currencyLocale).toString())
            .format(number)
            .replaceAll(regexErrorSpace, ' ');
    return formated;
  }

  static num revertCurrency(String value) {
    if (value.trim().isEmpty) return 0.0;
    var splittedValue = value.split(' ');
    if (splittedValue.length == 1) return 0.0;
    var replaced = splittedValue.last.replaceAll('.', '').replaceAll(',', '.');
    return num.tryParse(replaced) ?? 0.0;
  }

  static DateTime dueDateToDateTime(String dueDate) {
    final splittedDate = dueDate.split('/');
    return DateTime(
        int.parse(splittedDate.last), int.parse(splittedDate.first));
  }

  static TextInputFormatter monthYearFormatter() {
    return TextInputMask(
      mask: '99/9999',
      // reverse: true,
    );
  }

  static TextInputFormatter phoneFormatter() {
    return TextInputMask(
      mask: ['(99) 99999-9999'],
      reverse: false,
    );
  }

  static bool isValidEmail(String? email) {
    if (email == null) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String getNowTimeOfDay() {
    final now = TimeOfDay.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  static String getTimeOfDayFromSchedule(DateTime start, DateTime end) {
    final startHour = start.hour.toString().padLeft(2, '0');
    final startMinute = start.minute.toString().padLeft(2, '0');
    final endHour = end.hour.toString().padLeft(2, '0');
    final endMinute = end.minute.toString().padLeft(2, '0');

    return '$startHour:$startMinute - $endHour:$endMinute';
  }

  /// Formata o [value] de um [TextField] para moeda
  static TextInputFormatter currencyFormatter() {
    return TextInputMask(
      mask: ['R!\$! !9+.999,99'],
      reverse: true,
    );
  }

  static String getTimeToString(TimeOfDay? time) {
    if (time == null) return '-';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String getDurationToString(int duration) {
    return '${duration.toString().padLeft(2, '0')} Min';
  }

  static String convertTimeOfDay(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  static TimeOfDay revertTimeOfDay(String time) {
    final splittedTime = time.split(':');
    if (splittedTime.length == 2) {
      return TimeOfDay(
          hour: int.parse(splittedTime.first),
          minute: int.parse(splittedTime.last));
    }
    return TimeOfDay.now();
  }

  static String getTextToUri(String text) {
    return text.replaceAll(' ', '%20');
  }

  static String durationToString(Duration duration) {
    // Converte a duração em total de dias e horas
    int totalDays = duration.inDays;
    int hours = duration.inHours.remainder(24);

    // Calcula meses e anos a partir dos dias
    int years = totalDays ~/ 365;
    int months = (totalDays % 365) ~/ 30; // Aproximando 30 dias por mês
    int days = totalDays % 30; // Restante de dias após meses

    // Monta a string
    String result = '';

    if (years > 0) {
      result += '$years ano${years > 1 ? 's' : ''}';
    }
    if (months > 0) {
      result +=
          '${result.isNotEmpty ? ' e ' : ''}$months mês${months > 1 ? 's' : ''}';
    }
    if (days > 0) {
      result +=
          '${result.isNotEmpty ? ' e ' : ''}$days dia${days > 1 ? 's' : ''}';
    }
    if (hours > 0) {
      result +=
          '${result.isNotEmpty ? ' e ' : ''}$hours hora${hours > 1 ? 's' : ''}';
    }

    return result.isEmpty ? '0 horas' : result;
  }

  static DateTime buildDateWithDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  static DateTime buildDateWithoutTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static TextInputFormatter cepFormatter() {
    return TextInputMask(mask: '99999-999');
  }
}
