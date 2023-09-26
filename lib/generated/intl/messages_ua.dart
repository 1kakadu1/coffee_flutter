// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ua locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ua';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "couldNotLaunch":
            MessageLookupByLibrary.simpleMessage("не вдалося запустити"),
        "hintSearch": MessageLookupByLibrary.simpleMessage("Поиск продуктов"),
        "home_news_title":
            MessageLookupByLibrary.simpleMessage("Останні новини"),
        "home_search_title":
            MessageLookupByLibrary.simpleMessage("Знайдіть напій для себе "),
        "home_special_products":
            MessageLookupByLibrary.simpleMessage("Спеціальні продукти"),
        "loading": MessageLookupByLibrary.simpleMessage("Завантаження..."),
        "searchFind": MessageLookupByLibrary.simpleMessage("Знайдено:"),
        "searchTitle": MessageLookupByLibrary.simpleMessage(
            "Нам не вдалося знайти потрібний продукт! Спробуйте ввести, наприклад: \'кава\', \' чай \' або інше."),
        "seeAll": MessageLookupByLibrary.simpleMessage("Дивитися все"),
        "yourDrinks": MessageLookupByLibrary.simpleMessage("Наші напої")
      };
}
