import '../../../internationalization/text_decider.dart';

String LoginUsernameLabelText = TextDecider()
    .goOnPath('LoginScreen')
    .goOnPath('Username')
    .target('LabelText')
    .decideText();
String LoginUsernameHintText = TextDecider()
    .goOnPath('LoginScreen')
    .goOnPath('Username')
    .target('HintText')
    .decideText();
String LoginPasswordLabelText = TextDecider()
    .goOnPath('LoginScreen')
    .goOnPath('Password')
    .target('LabelText')
    .decideText();
String LoginPasswordHintText = TextDecider()
    .goOnPath('LoginScreen')
    .goOnPath('Password')
    .target('HintText')
    .decideText();

String Login =
    TextDecider().goOnPath('LoginScreen').target('LoginButton').decideText();
String DontHaveAccount =
    TextDecider().goOnPath('LoginScreen').target('NoAccount').decideText();
String SignUp =
    TextDecider().goOnPath('LoginScreen').target('SignUp').decideText();

String PleaseEnterValidInputs = TextDecider()
    .goOnPath('LoginScreen')
    .target('PleaseEnterValidInputs')
    .decideText();
String UserNameDoesNotExists = TextDecider()
    .goOnPath('LoginScreen')
    .target('UsernameDoesNotExists')
    .decideText();
String PasswordIsNotCorrect = TextDecider()
    .goOnPath('LoginScreen')
    .target('PasswordIsNotCorrect')
    .decideText();
