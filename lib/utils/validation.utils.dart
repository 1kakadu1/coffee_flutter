import 'package:intl/intl.dart';

class ErrorText {
  static final _lang = Intl.getCurrentLocale();
  static String req() {
    return _lang == "ru"
        ? 'Поле обязательно для ввода'
        : _lang == "ua" || _lang == "uk"
            ? "Поле обов'язково для введення"
            : "The field is required for input";
  }

  static String phoneLen() {
    return _lang == "ru"
        ? 'Введите верно номер'
        : _lang == "ua" || _lang == "uk"
            ? "Введіть вірно номер"
            : "Enter the correct number";
  }

  static String email() {
    return _lang == "ru"
        ? 'Введите верно email'
        : _lang == "ua" || _lang == "uk"
            ? "Введіть вірно email"
            : "Enter the correct email";
  }

  static String passwordMin() {
    return _lang == "ru"
        ? 'Пароль должен быть больше 6'
        : _lang == "ua" || _lang == "uk"
            ? "Пароль повинен бути більше 6"
            : "The password must be greater than 6";
  }

  static String confirmPassword() {
    return _lang == "ru"
        ? 'Пароли не совпали'
        : _lang == "ua"
            ? "Паролі не збіглися"
            : "Passwords didn't match";
  }

  static String time(String start, String end) {
    return _lang == "ru"
        ? 'Введите время в диапазоне $start - $end'
        : _lang == "ua"
            ? "Введіть час в діапазоні $start - $end"
            : "Enter the time in the range $start - $end";
  }
}

String? validationPhone(String? value) {
  if (value == null || value.isEmpty) {
    return ErrorText.req();
  }
  if (value.length != 17) {
    return ErrorText.phoneLen();
  }
  return null;
}

String? validationEmail(String? value) {
  if (value == null || value.isEmpty) {
    return ErrorText.req();
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return ErrorText.email();
  }
  return null;
}

String? validationString(String? value) {
  if (value == null || value.isEmpty) {
    return ErrorText.req();
  }
  return null;
}

String? validationPassword(String? value,
    {bool isConfirm = false, String? confirm}) {
  if (value == null || value.isEmpty) {
    return ErrorText.req();
  }
  if (value.length < 6) {
    return ErrorText.passwordMin();
  }
  if (isConfirm == true && value != confirm) {
    return ErrorText.confirmPassword();
  }
  return null;
}

String? validationTimeOrder(String? value) {
  if (value == null || value.isEmpty) {
    return ErrorText.req();
  }
  final split = value.split(":");
  final h = int.parse(split[0]);
  final m = int.parse(split[0]);
  if (h > 18 || h < 9) {
    return ErrorText.time('9:00', '17:30');
  }

  if (h >= 18 && m >= 0) {
    return ErrorText.time('9:00', '17:30');
  }

  if (h <= 9 && (m == 0 || m == 30)) {
    return ErrorText.time('9:00', '17:30');
  }
  return null;
}
