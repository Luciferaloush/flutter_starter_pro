import 'dart:ui';

import '../utils/app_shared_preferences.dart';


class AppConstants {
 static const String appName = 'My App';
 static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];
 static const String localeKey = 'app_locale';
 static const String themeKey = 'app_theme';
 static  String token = AppPreferences().getData("token");
 static Future<String?> getUserToken() async {
  return await AppPreferences().getData("token");
 }
}
