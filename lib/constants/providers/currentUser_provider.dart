import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/authentication/model/user_model.dart';
import '../../screens/imports.dart';

final userIDProvider = StateProvider<UserIDModel>((ref) {
  return UserIDModel();
});

class UserIDModel extends ChangeNotifier {
  late int _userID;

  int get getUserID => _userID;

  set setUserID(int value) {
    _userID = value;

    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<UserModel>'
    notifyListeners();
  }
}
