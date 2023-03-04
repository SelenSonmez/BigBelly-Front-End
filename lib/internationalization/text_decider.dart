import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class TextDecider {
  static String _language = "";
  String _path = "";
  String _targetText = "";
  static Map<String, dynamic>? _languageMap;

  Future<bool> load() async {
    String json =
        await rootBundle.loadString("assets/languages/$_language.json");
    Map<String, dynamic> decodedJson = jsonDecode(json);

    _languageMap = decodedJson;

    return true;
  }

  String decideText() {
    dynamic possilbeTargetObject = _languageMap;

    for (String pathMember in _path.split("-")) {
      possilbeTargetObject = possilbeTargetObject[pathMember];
    }

    String returnString = possilbeTargetObject[_targetText];

    return returnString;
  }

  TextDecider setPreferredLanguage(String language) {
    _language = language;

    return this;
  }

  TextDecider goOnPath(String path) {
    if (path.isEmpty) _path += path;

    _path += "$path-";

    return this;
  }

  TextDecider target(String targetText) {
    _targetText = targetText;

    if (_path.endsWith("-")) _path = _path.substring(0, _path.length - 1);

    return this;
  }
}
