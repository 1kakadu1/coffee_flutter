List<String> parseArrayString(List<dynamic>? value, List<String> emptyValue) {
  if (value != null) {
    final v = value;
    final arr0 = <String>[];
    v.forEach((v) {
      arr0.add(v.toString());
    });
    return arr0;
  }

  return [];
}

List<Map<String, T>> parseArrayMap<T>(
    List<dynamic>? value, List<Map<String, T>> emptyValue) {
  if (value != null) {
    final v = value;
    final arr0 = <Map<String, T>>[];
    v.forEach((v) {
      arr0.add(Map<String, T>.from(v));
    });
    return arr0;
  }

  return emptyValue;
}
