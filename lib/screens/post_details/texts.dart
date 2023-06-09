import '../../internationalization/text_decider.dart';

String Details =
    TextDecider().goOnPath('PostDetailsScreen').target('Details').decideText();
String Difficulty = TextDecider()
    .goOnPath('PostDetailsScreen')
    .target('Difficulty')
    .decideText();
String Easy =
    TextDecider().goOnPath('PostDetailsScreen').target('Easy').decideText();
String Medium =
    TextDecider().goOnPath('PostDetailsScreen').target('Medium').decideText();
String Hard =
    TextDecider().goOnPath('PostDetailsScreen').target('Hard').decideText();
String PreparationTime = TextDecider()
    .goOnPath('PostDetailsScreen')
    .target('PreparationTime')
    .decideText();
String BakingTime = TextDecider()
    .goOnPath('PostDetailsScreen')
    .target('BakingTime')
    .decideText();
String Ingredients = TextDecider()
    .goOnPath('PostDetailsScreen')
    .target('Ingredients')
    .decideText();
String Servings =
    TextDecider().goOnPath('PostDetailsScreen').target('Servings').decideText();
String Calories =
    TextDecider().goOnPath('PostDetailsScreen').target('Calories').decideText();
String EstimatedValue = TextDecider()
    .goOnPath('PostDetailsScreen')
    .target('EstimatedValue')
    .decideText();
String Steps =
    TextDecider().goOnPath('PostDetailsScreen').target('Steps').decideText();
String Tags =
    TextDecider().goOnPath('PostDetailsScreen').target('Tags').decideText();
String None =
    TextDecider().goOnPath('PostDetailsScreen').target('None').decideText();
