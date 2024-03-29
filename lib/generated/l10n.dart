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

  /// `Your Email`
  String get labelEmail {
    return Intl.message(
      'Your Email',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get labelPassword {
    return Intl.message(
      'Your password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get btnSingin {
    return Intl.message(
      'Login',
      name: 'btnSingin',
      desc: '',
      args: [],
    );
  }

  /// `No account ?`
  String get linkCreateAccount {
    return Intl.message(
      'No account ?',
      name: 'linkCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sing In`
  String get singIn {
    return Intl.message(
      'Sing In',
      name: 'singIn',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Shall we create an account?`
  String get createTittle {
    return Intl.message(
      'Shall we create an account?',
      name: 'createTittle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get labelName {
    return Intl.message(
      'Name',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get labelPhone {
    return Intl.message(
      'Phone',
      name: 'labelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get labelRepeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'labelRepeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get btnRegistration {
    return Intl.message(
      'Registration',
      name: 'btnRegistration',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully registered`
  String get msgRegistratiopnSuccess {
    return Intl.message(
      'You have successfully registered',
      name: 'msgRegistratiopnSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Total to be paid:`
  String get totalPayment {
    return Intl.message(
      'Total to be paid:',
      name: 'totalPayment',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get titleCreateOrder {
    return Intl.message(
      'Checkout',
      name: 'titleCreateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Composition:`
  String get composition {
    return Intl.message(
      'Composition:',
      name: 'composition',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `hide`
  String get hide {
    return Intl.message(
      'hide',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Description: `
  String get description {
    return Intl.message(
      'Description: ',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get screenFavorite {
    return Intl.message(
      'Favorites',
      name: 'screenFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get screenCart {
    return Intl.message(
      'Shopping Cart',
      name: 'screenCart',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get screenContacts {
    return Intl.message(
      'Contacts',
      name: 'screenContacts',
      desc: '',
      args: [],
    );
  }

  /// `You don't have a selected product yet`
  String get emptyFavorite {
    return Intl.message(
      'You don\'t have a selected product yet',
      name: 'emptyFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get screenProducts {
    return Intl.message(
      'Products',
      name: 'screenProducts',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get screenOrder {
    return Intl.message(
      'Checkout',
      name: 'screenOrder',
      desc: '',
      args: [],
    );
  }

  /// `Place an order for`
  String get labelRangeTime {
    return Intl.message(
      'Place an order for',
      name: 'labelRangeTime',
      desc: '',
      args: [],
    );
  }

  /// `To the store`
  String get labelShop {
    return Intl.message(
      'To the store',
      name: 'labelShop',
      desc: '',
      args: [],
    );
  }

  /// `issue`
  String get labelCreateOrder {
    return Intl.message(
      'issue',
      name: 'labelCreateOrder',
      desc: '',
      args: [],
    );
  }

  /// `The order has been successfully placed!`
  String get orderCreateSuccess {
    return Intl.message(
      'The order has been successfully placed!',
      name: 'orderCreateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error! Repeat after a while`
  String get orderError {
    return Intl.message(
      'Error! Repeat after a while',
      name: 'orderError',
      desc: '',
      args: [],
    );
  }

  /// `We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know`
  String get aboutItemBody1 {
    return Intl.message(
      'We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know',
      name: 'aboutItemBody1',
      desc: '',
      args: [],
    );
  }

  /// `If there are comments`
  String get aboutItemHeader1 {
    return Intl.message(
      'If there are comments',
      name: 'aboutItemHeader1',
      desc: '',
      args: [],
    );
  }

  /// `Visa, MasterCard payment`
  String get aboutItemBody2 {
    return Intl.message(
      'Visa, MasterCard payment',
      name: 'aboutItemBody2',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get aboutItemHeader2 {
    return Intl.message(
      'Payment',
      name: 'aboutItemHeader2',
      desc: '',
      args: [],
    );
  }

  /// `We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know`
  String get aboutItemBody3 {
    return Intl.message(
      'We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know',
      name: 'aboutItemBody3',
      desc: '',
      args: [],
    );
  }

  /// `Didn't like the product?`
  String get aboutItemHeader3 {
    return Intl.message(
      'Didn\'t like the product?',
      name: 'aboutItemHeader3',
      desc: '',
      args: [],
    );
  }

  /// `We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know`
  String get aboutItemHeader4 {
    return Intl.message(
      'We monitor the quality of our work very closely, so if you have any comments or suggestions, be sure to let us know',
      name: 'aboutItemHeader4',
      desc: '',
      args: [],
    );
  }

  /// `Didn't you get something?`
  String get aboutItemBody4 {
    return Intl.message(
      'Didn\'t you get something?',
      name: 'aboutItemBody4',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get screenAbout {
    return Intl.message(
      'About us',
      name: 'screenAbout',
      desc: '',
      args: [],
    );
  }

  /// `Delivery schedule:`
  String get titleTimeWork {
    return Intl.message(
      'Delivery schedule:',
      name: 'titleTimeWork',
      desc: '',
      args: [],
    );
  }

  /// `from 10:00-21:00`
  String get timeWorkAbout {
    return Intl.message(
      'from 10:00-21:00',
      name: 'timeWorkAbout',
      desc: '',
      args: [],
    );
  }

  /// `Cafe opening hours:`
  String get timeWorkShop {
    return Intl.message(
      'Cafe opening hours:',
      name: 'timeWorkShop',
      desc: '',
      args: [],
    );
  }

  /// `from 08:00-21:00`
  String get timeShop {
    return Intl.message(
      'from 08:00-21:00',
      name: 'timeShop',
      desc: '',
      args: [],
    );
  }

  /// `Minimum order:`
  String get titleMinOrder {
    return Intl.message(
      'Minimum order:',
      name: 'titleMinOrder',
      desc: '',
      args: [],
    );
  }

  /// `Free delivery by foot courier with an order amount of 10 \$ Delivery by a taxi operator from any order amount - according to the carrier's tariffs.`
  String get minOrderInfo {
    return Intl.message(
      'Free delivery by foot courier with an order amount of 10 \\\$ Delivery by a taxi operator from any order amount - according to the carrier\'s tariffs.',
      name: 'minOrderInfo',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get productSize {
    return Intl.message(
      'Size',
      name: 'productSize',
      desc: '',
      args: [],
    );
  }

  /// `tea`
  String get markerTea {
    return Intl.message(
      'tea',
      name: 'markerTea',
      desc: '',
      args: [],
    );
  }

  /// `coffee`
  String get markerCoffee {
    return Intl.message(
      'coffee',
      name: 'markerCoffee',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get screenProfile {
    return Intl.message(
      'Profile',
      name: 'screenProfile',
      desc: '',
      args: [],
    );
  }

  /// `Your data`
  String get titleProfile {
    return Intl.message(
      'Your data',
      name: 'titleProfile',
      desc: '',
      args: [],
    );
  }

  /// `Data successfully updated`
  String get profileSuccessUpdateData {
    return Intl.message(
      'Data successfully updated',
      name: 'profileSuccessUpdateData',
      desc: '',
      args: [],
    );
  }

  /// `Upload new photo`
  String get btnUpload {
    return Intl.message(
      'Upload new photo',
      name: 'btnUpload',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded`
  String get btnProgress {
    return Intl.message(
      'Uploaded',
      name: 'btnProgress',
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
      Locale.fromSubtags(languageCode: 'uk'),
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
