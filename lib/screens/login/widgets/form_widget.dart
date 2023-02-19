import 'package:bigbelly/screens/login/widgets/login_button.dart';
import 'package:bigbelly/screens/login/widgets/password_field.dart';
import 'package:bigbelly/screens/login/widgets/username_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({Key? key}) : super(key: key);

  final dynamic _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 25, 8, 18),
              child: UsernameTextField(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 20),
              child: PasswordTextField(),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      style: TextStyle(fontSize: 16),
                      "Don't have an account yet?  "),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.green)),
                    onPressed: () {
                      /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterScreen())));*/
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
            LoginButton(
              formKey: _formkey,
            ),
          ],
        ));
  }
}
