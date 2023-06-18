import '../../internationalization/text_decider.dart';

String Search = TextDecider()
    .goOnPath("SearchScreen")
    .target("Search")
    .decideText();