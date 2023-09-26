// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Latest news`
  String get home_news_title {
    return Intl.message(
      'Latest news',
      name: 'home_news_title',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch`
  String get couldNotLaunch {
    return Intl.message(
      'Could not launch',
      name: 'couldNotLaunch',
      desc: '',
      args: [],
    );
  }

  /// `Special products`
  String get home_special_products {
    return Intl.message(
      'Special products',
      name: 'home_special_products',
      desc: '',
      args: [],
    );
  }

  /// `View all `
  String get seeAll {
    return Intl.message(
      'View all ',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Our drinks`
  String get yourDrinks {
    return Intl.message(
      'Our drinks',
      name: 'yourDrinks',
      desc: '',
      args: [],
    );
  }

  /// `Find a drink for yourself`
  String get home_search_title {
    return Intl.message(
      'Find a drink for yourself',
      name: 'home_search_title',
      desc: '',
      args: [],
    );
  }

  /// `Product search`
  String get hintSearch {
    return Intl.message(
      'Product search',
      name: 'hintSearch',
      desc: '',
      args: [],
    );
  }

  /// `Found:`
  String get searchFind {
    return Intl.message(
      'Found:',
      name: 'searchFind',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find the right product! Try typing, for example: 'coffee', 'tea' or other.`
  String get searchTitle {
    return Intl.message(
      'We couldn\'t find the right product! Try typing, for example: \'coffee\', \'tea\' or other.',
      name: 'searchTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'ua'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
