import '../../../internationalization/text_decider.dart';

String RegisterNameLabelText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Name')
    .target('LabelText')
    .decideText();
String RegisterNameHintText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Name')
    .target('HintText')
    .decideText();
String RegisterSurnameLabelText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Surname')
    .target('LabelText')
    .decideText();
String RegisterSurnameHintText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Surname')
    .target('HintText')
    .decideText();

String RegisterUsernameLabelText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Username')
    .target('LabelText')
    .decideText();
String RegisterUsernameHintText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Username')
    .target('HintText')
    .decideText();

String RegisterEmailLabelText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Email')
    .target('LabelText')
    .decideText();
String RegisterEmailHintText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Email')
    .target('HintText')
    .decideText();
String RegisterPasswordLabelText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Password')
    .target('LabelText')
    .decideText();
String RegisterPasswordHintText = TextDecider()
    .goOnPath('RegisterScreen')
    .goOnPath('Password')
    .target('HintText')
    .decideText();
String NameCantBeEmpty = TextDecider()
    .goOnPath('RegisterScreen')
    .target('NameNotEmpty')
    .decideText();
String SurnameCantBeEmpty = TextDecider()
    .goOnPath('RegisterScreen')
    .target('SurnameNotEmpty')
    .decideText();
String UsernameCantBeEmpty = TextDecider()
    .goOnPath('RegisterScreen')
    .target('UsernameNotEmpty')
    .decideText();
String EmailCantBeEmpty = TextDecider()
    .goOnPath('RegisterScreen')
    .target('EmailNotEmpty')
    .decideText();
String PasswordCantBeEmpty = TextDecider()
    .goOnPath('RegisterScreen')
    .target('PasswordNotEmpty')
    .decideText();

String UsernameNotValid = TextDecider()
    .goOnPath('RegisterScreen')
    .target('UsernameNotValid')
    .decideText();
String EmailNotValid = TextDecider()
    .goOnPath('RegisterScreen')
    .target('EmailNotValid')
    .decideText();
String PasswordNotValid = TextDecider()
    .goOnPath('RegisterScreen')
    .target('PasswordNotValid')
    .decideText();

String AlreadyHaveAccount = TextDecider()
    .goOnPath('RegisterScreen')
    .target('AlreadyHaveAccount')
    .decideText();
String SignIn =
    TextDecider().goOnPath('RegisterScreen').target('SignIn').decideText();

String Register =
    TextDecider().goOnPath('RegisterScreen').target('Register').decideText();
