import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/authentication/model/user_model.dart';
import '../../screens/imports.dart';

final userProvider = StateProvider<UserModel>((ref) {
  return UserModel();
});

class UserModel extends ChangeNotifier {
  late User _user;

  User get getUser => _user;

  set setUser(User value) {
    _user = value;

    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<UserModel>'
    notifyListeners();
  }
}
