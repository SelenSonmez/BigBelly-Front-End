import 'package:bigbelly/screens/imports.dart';

String Name =
    TextDecider().goOnPath("EditProfileScreen").target("Name").decideText();
String OldPassword = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("OldPassword")
    .decideText();
String NewPassword = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("NewPassword")
    .decideText();
String PasswordIsNotMatched = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("PasswordIsNotMatched")
    .decideText();
String Edit =
    TextDecider().goOnPath("EditProfileScreen").target("Edit").decideText();
String EditProfileInformation = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("EditProfileInformation")
    .decideText();
String OldPasswordNotEmpty = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("OldPasswordNotEmpty")
    .decideText();
String NewPasswordNotEmpty = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("NewPasswordNotEmpty")
    .decideText();
String RequierementsNotMet = TextDecider()
    .goOnPath("EditProfileScreen")
    .target("RequierementsNotMet")
    .decideText();
