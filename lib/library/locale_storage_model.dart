import 'package:flutter/material.dart';

class LocaleStorageModel {
  String _localeTag = '';
  String _countryCode = '';

  String get localeTag => _localeTag;

  String get countryCode => _countryCode;

  bool updateLocale(Locale locale) {
    final localeTag = locale.toLanguageTag();
    final countryCode = locale.countryCode;
    if (_localeTag == localeTag && _countryCode == countryCode) return false;
    _localeTag = localeTag;
    _countryCode = countryCode ?? '';
    return true;
  }
}
