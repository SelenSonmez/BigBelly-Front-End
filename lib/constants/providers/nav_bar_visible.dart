import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarProvider = StateProvider<NavBarModel>((ref) {
  return NavBarModel();
});

class NavBarModel extends ChangeNotifier {
  bool _isVisible = true;

  set setVisible(bool visibility) {
    _isVisible = visibility;
    notifyListeners();
  }

  bool get isVisible => _isVisible;
}
