import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordFieldValidatorStateProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);
