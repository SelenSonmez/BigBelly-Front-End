import 'dart:convert';

class LoginRepository {
  Future login(Map<String, dynamic> formFields) async {
    print(jsonEncode(formFields));
    await Future.delayed(const Duration(seconds: 3));

    throw Exception("Login failed");
  }
}
