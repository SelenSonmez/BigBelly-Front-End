import 'package:bigbelly/internationalization/text_decider.dart';

String Settings =
    TextDecider().goOnPath("SettingsScreen").target("Settings").decideText();
String Account =
    TextDecider().goOnPath("SettingsScreen").target("Account").decideText();
String ArchivedRecipe = TextDecider()
    .goOnPath("SettingsScreen")
    .target("ArchivedRecipe")
    .decideText();
String Langugae =
    TextDecider().goOnPath("SettingsScreen").target("Langugae").decideText();
String EditProfile =
    TextDecider().goOnPath("SettingsScreen").target("EditProfile").decideText();
String Privacy =
    TextDecider().goOnPath("SettingsScreen").target("Privacy").decideText();
String Content =
    TextDecider().goOnPath("SettingsScreen").target("Content").decideText();
String Collections =
    TextDecider().goOnPath("SettingsScreen").target("Collections").decideText();
String Recipes =
    TextDecider().goOnPath("SettingsScreen").target("Recipes").decideText();
String Help =
    TextDecider().goOnPath("SettingsScreen").target("Help").decideText();
String Report =
    TextDecider().goOnPath("SettingsScreen").target("Report").decideText();
String AboutBigBelly = TextDecider()
    .goOnPath("SettingsScreen")
    .target("AboutBigBelly")
    .decideText();
String PrivateAccount = TextDecider()
    .goOnPath("SettingsScreen")
    .target("PrivateAccount")
    .decideText();
String ThemeBelly =
    TextDecider().goOnPath("SettingsScreen").target("Theme").decideText();
String LogOut =
    TextDecider().goOnPath("SettingsScreen").target("LogOut").decideText();
String Light =
    TextDecider().goOnPath("SettingsScreen").target("Light").decideText();
String Dark =
    TextDecider().goOnPath("SettingsScreen").target("Dark").decideText();
String ContactBigBelly = TextDecider()
    .goOnPath("SettingsScreen")
    .target("ContactBigBelly")
    .decideText();
String About =
    TextDecider().goOnPath("SettingsScreen").target("About").decideText();
String Unarchived =
    TextDecider().goOnPath("SettingsScreen").target("Unarchived").decideText();
