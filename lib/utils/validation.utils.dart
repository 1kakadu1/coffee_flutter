String? validationPhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Поле обязательно для ввода';
  }
  if (value.length != 17) {
    return 'Введите верно номер';
  }
  return null;
}

String? validationString(String? value) {
  if (value == null || value.isEmpty) {
    return 'Поле обязательно для ввода';
  }
  return null;
}

String? validationTimeOrder(String? value) {
  if (value == null || value.isEmpty) {
    return 'Поле обязательно для ввода';
  }
  final split = value.split(":");
  final h = int.parse(split[0]);
  final m = int.parse(split[0]);
  if (h > 18 || h < 9) {
    return 'Введите время в диапазоне 9:00 - 17.30';
  }

  if (h >= 18 && m >= 0) {
    return 'Введите время в диапазоне 9:00 - 17.30';
  }

  if (h <= 9 && (m == 0 || m == 30)) {
    return 'Введите время в диапазоне 9:00 - 17.30';
  }
  return null;
}
