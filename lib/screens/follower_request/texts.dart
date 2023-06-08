import '../../internationalization/text_decider.dart';

String FollowerRequests = TextDecider()
    .goOnPath('FollowerScreen')
    .target('FollowerRequests')
    .decideText();
