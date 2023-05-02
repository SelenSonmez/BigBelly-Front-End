import '../../internationalization/text_decider.dart';

String TitleTextField = TextDecider()
    .goOnPath('AddPostScreen')
    .target('TitleTextField')
    .target("LabelText")
    .decideText();

String AddARecipePhoto = TextDecider()
    .goOnPath("AddPostScreen")
    .target(TitleTextField)
    .target("HintText")
    .decideText();
