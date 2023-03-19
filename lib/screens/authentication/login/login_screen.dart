import 'dart:convert';

import 'package:bigbelly/screens/authentication/model/user_model.dart';
import 'package:bigbelly/screens/imports.dart';

import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:bigbelly/screens/verification/verification_screen.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

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
            Hero(tag: "logo", child: Image.asset(logoImage)),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 35.h, 15.w, 18.w),
                        child: BigBellyTextField(
                            labelText: LoginUsernameLabelText,
                            hintText: LoginUsernameHintText,
                            icon: const Icon(Icons.account_circle_rounded),
                            onSaved: (newValue) =>
                                fields['username'] = newValue)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.h),
                        child: BigBellyTextField(
                            labelText: LoginPasswordLabelText,
                            hintText: LoginPasswordHintText,
                            icon: const Icon(Icons.lock_open_rounded),
                            onSaved: (newValue) =>
                                fields['password'] = newValue)),
                    Container(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DontHaveAccount,
                            style: TextStyle(fontSize: 16.sp),
                          ),
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
                            child: Text(SignUp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
                      child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();
                            try {
                              login(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(e.toString())));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 5.h,
                              minimumSize: Size.fromHeight(50.h),
                              backgroundColor: mainThemeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.w),
                              )),
                          child: Text(
                            Login,
                            style: registerLoginButtonTextStyle,
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }

  Future login(context) async {
    Response response = await dio.post('/account/login', data: fields);

    if (response.statusCode != 400) {
      User user = User.fromJson(response.data['payload']);
      await SessionManager().set('user', user);

      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const MainPage())));
      } else if (response.statusCode == 300) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    PinCodeVerificationScreen(user.username))));
      }
    }
    //debugPrint(response.data.toString());
  }
}
