import '../../../internationalization/text_decider.dart';

String EmailVerification = TextDecider()
    .goOnPath('VerificationScreen')
    .target('EmailVerification')
    .decideText();
String EnterCodeSentTo = TextDecider()
    .goOnPath('VerificationScreen')
    .target('EnterCodeSentTo')
    .decideText();
String DidntReceiveTheCode = TextDecider()
    .goOnPath('VerificationScreen')
    .target('DidntReceiveTheCode')
    .decideText();
String Resend =
    TextDecider().goOnPath('VerificationScreen').target('Resend').decideText();
String Verify =
    TextDecider().goOnPath('VerificationScreen').target('Verify').decideText();
String Clear =
    TextDecider().goOnPath('VerificationScreen').target('Clear').decideText();
String PleaseFillAllSpaces = TextDecider()
    .goOnPath('VerificationScreen')
    .target('PleaseFillAllSpaces')
    .decideText();
String CodeMatched = TextDecider()
    .goOnPath('VerificationScreen')
    .target('CodeMatched')
    .decideText();
String WrongCode = TextDecider()
    .goOnPath('VerificationScreen')
    .target('WrongCode')
    .decideText();
