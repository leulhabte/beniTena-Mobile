import 'package:flutter/material.dart';
import 'demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key){
  return DemoLocalization.of(context).getTranslated(key);
}

const String ENGLISH = 'en';
const String AMHARIC = 'am';

const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  await _pref.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String lang){
  Locale _temp;
  switch(lang){
    case ENGLISH:
      _temp = Locale(lang, 'US');
      break;
    case AMHARIC:
      _temp = Locale(lang, 'ETH');
      break;
    default: _temp = Locale(AMHARIC, 'ETH');
  }

  return _temp;
}

Future<Locale> getLocale() async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String languageCode = _pref.getString(LANGUAGE_CODE) ?? AMHARIC;
  return _locale(languageCode);
}