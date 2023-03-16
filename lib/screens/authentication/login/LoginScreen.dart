import 'package:bigbelly/constants/Dio.dart';
import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:bigbelly/screens/authentication/helpers/BigBellyTextField.dart';
import 'package:bigbelly/screens/authentication/register/RegisterScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../constants/Colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {'username': null, 'password': null};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(tag: "logo", child: logoImage),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 18),
                        child: BigBellyTextField(
                            labelText: TextDecider()
                                .goOnPath('LoginScreen')
                                .goOnPath('Username')
                                .target('LabelText')
                                .decideText(),
                            hintText: TextDecider()
                                .goOnPath('LoginScreen')
                                .goOnPath('Username')
                                .target('HintText')
                                .decideText(),
                            icon: const Icon(Icons.account_circle_rounded),
                            onSaved: (newValue) =>
                                fields['username'] = newValue)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: BigBellyTextField(
                            labelText: TextDecider()
                                .goOnPath('LoginScreen')
                                .goOnPath('Password')
                                .target('LabelText')
                                .decideText(),
                            hintText: TextDecider()
                                .goOnPath('LoginScreen')
                                .goOnPath('Password')
                                .target('HintText')
                                .decideText(),
                            icon: const Icon(Icons.lock_open_rounded),
                            onSaved: (newValue) =>
                                fields['password'] = newValue)),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              style: const TextStyle(fontSize: 16),
                              TextDecider()
                                  .goOnPath('LoginScreen')
                                  .target('NoAccount')
                                  .decideText()),
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle:
                                    const TextStyle(color: Colors.green)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          RegisterScreen())));
                            },
                            child: Text(TextDecider()
                                .goOnPath('LoginScreen')
                                .target('SignUp')
                                .decideText()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();

                            Response response =
                                await dio.post('/account/login', data: fields);

                            debugPrint(response.data.toString());
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: mainThemeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                          child: Text(
                            TextDecider()
                                .goOnPath('LoginScreen')
                                .target('LoginButton')
                                .decideText(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }

  void showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
