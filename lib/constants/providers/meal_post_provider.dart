import 'package:bigbelly/screens/model/menu_ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/imports.dart';

final mealPostProvider = StateProvider<MealModel>((ref) {
  return MealModel();
});

class MealModel extends ChangeNotifier {
  MenuIngredient _ingredient = MenuIngredient(
      title: "", imageUrl: "", ingredients: [], isMealHidden: false, price: 0);

  MenuIngredient get getMenuIngredient => _ingredient;

  set setMenuIngredient(MenuIngredient value) {
    _ingredient = value;

    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<MealModel>'
    notifyListeners();
  }
}
