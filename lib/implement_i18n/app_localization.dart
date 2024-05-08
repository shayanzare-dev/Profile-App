import 'package:flutter/cupertino.dart';
import 'package:flutter_application/implement_i18n/base_class.dart';
import 'en.dart';
import 'fa.dart';

class AppLocalization extends LocalizationsDelegate<Languages> {
  const AppLocalization();
  @override
  bool isSupported(Locale locale) {
    return ['fa', 'en'].contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return EnLanguages();
      case 'fa':
        return FaLanguages();
      default:
        return EnLanguages();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
