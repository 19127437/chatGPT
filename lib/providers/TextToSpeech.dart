// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
Future<String> getLocalLanguage() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('setLanguage')?? "en-US";
}

String setLanguage = "en-US" ;

bool autoSpeech = false;