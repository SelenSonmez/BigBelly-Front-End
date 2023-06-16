import '../../internationalization/text_decider.dart';

String Recommendation = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("Recommendation")
    .decideText();
String RecommendationHistory = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("RecommendationHistory")
    .decideText();
String SeeAll = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("SeeAll")
    .decideText();
String GetRecommendation = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("GetRecommendation")
    .decideText();
String ForSelf = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("ForSelf")
    .decideText();
String ForGroup = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("ForGroup")
    .decideText();
String By =
    TextDecider().goOnPath("RecommendationScreen").target("By").decideText();
String AddFriends = TextDecider()
    .goOnPath("RecommendationScreen")
    .target("AddFriends")
    .decideText();
String Get =
    TextDecider().goOnPath("RecommendationScreen").target("Get").decideText();
