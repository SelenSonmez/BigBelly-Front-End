import '../../internationalization/text_decider.dart';

String MealName =
    TextDecider().goOnPath("MealMenuScreen").target("MealName").decideText();
String Price =
    TextDecider().goOnPath("MealMenuScreen").target("Price").decideText();

String HideIngredients = TextDecider()
    .goOnPath("MealMenuScreen")
    .target("HideIngredients")
    .decideText();

String IngredientsAreNecc = TextDecider()
    .goOnPath("MealMenuScreen")
    .target("IngredientsAreNecc")
    .decideText();
String CreateMenuItem = TextDecider()
    .goOnPath("MealMenuScreen")
    .target("CreateMenuItem")
    .decideText();
String Ingredient =
    TextDecider().goOnPath("MealMenuScreen").target("Ingredient").decideText();
