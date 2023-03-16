import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';

//Language converter class for password field validator
class ValidatorLanguage implements FlutterPwValidatorStrings {
  @override
  final String atLeast =
      "${TextDecider().goOnPath('RegisterScreen').target('AtLeast').decideText()} - ${TextDecider().goOnPath('RegisterScreen').target('Character').decideText()}";
  @override
  final String uppercaseLetters =
      "- ${TextDecider().goOnPath('RegisterScreen').target('UpperCaseLetter').decideText()}";
  @override
  final String numericCharacters =
      "- ${TextDecider().goOnPath('RegisterScreen').target('NumericCharacter').decideText()}";
  @override
  final String specialCharacters =
      "- ${TextDecider().goOnPath('RegisterScreen').target('SpecialCharacter').decideText()}";

  @override
  String get normalLetters =>
      "- ${TextDecider().goOnPath('RegisterScreen').target('NormalLetter').decideText()}";
}
