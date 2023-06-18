import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/authentication/model/user_model.dart';
import '../../screens/imports.dart';

final userProvider = StateProvider<UserModel>((ref) {
  return UserModel();
});

class UserModel extends ChangeNotifier {
  late User _user;

  bool isFollowingUser = false;

  User get getUser => _user;

  set setUser(User value) {
    _user = value;

    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<UserModel>'
    notifyListeners();
  }

  bool get getFollowingStatus => isFollowingUser;

  set setFollowingStatus(bool value) {
    isFollowingUser = value;

    //here the model value changes. you can call 'notifyListeners' to notify all the 'Consumer<UserModel>'
    notifyListeners();
  }

  void setPostCount(int count) {
    if (_user.postCount != count) {
      _user.postCount = count;

      notifyListeners();
    }
  }

  void userUnfollowedPrivateAccount(String id) {
    isFollowingUser = false;
    notifyListeners();
  }
}
