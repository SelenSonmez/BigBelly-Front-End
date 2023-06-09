import '../../../internationalization/text_decider.dart';

String Posts =
    TextDecider().goOnPath('ProfileScreen').target('Posts').decideText();
String Followers =
    TextDecider().goOnPath('ProfileScreen').target('Followers').decideText();
String Following =
    TextDecider().goOnPath('ProfileScreen').target('Following').decideText();
