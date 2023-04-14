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

  void removeFollower(var userID) {
    _user.followers!.removeWhere((item) => item.id == userID);

    notifyListeners();
  }

  Future addFollower(var id) async {
    final uri = '/profile/$id/';

    try {
      Response response = await dio.get(uri);
      User user = User.fromJson(response.data['payload']['user']);
      _user.followers!.add(user);
      print(_user.followers!.length.toString());
      notifyListeners();
    } catch (_) {}
  }
}
