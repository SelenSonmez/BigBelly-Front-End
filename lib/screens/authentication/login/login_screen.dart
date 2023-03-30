// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bigbelly/constants/providers/user_provider.dart';
import 'dart:convert';

import 'package:bigbelly/screens/authentication/verification/verification_screen.dart';
import 'package:bigbelly/screens/imports.dart';

import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';

import '../model/user_model.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../helpers/page_below_string.dart';
import '../register/texts.dart';

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
                          onSaved: (newValue) => fields['username'] = newValue,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return NameCantBeEmpty;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 20.h),
                        child: BigBellyTextField(
                            isPassword: true,
                            labelText: LoginPasswordLabelText,
                            hintText: LoginPasswordHintText,
                            icon: const Icon(Icons.lock_open_rounded),
                            onSaved: (newValue) =>
                                fields['password'] = newValue,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return PasswordCantBeEmpty;
                            })),
                    PageBelowString(
                        actionString: SignUp,
                        longString: DontHaveAccount,
                        type: "signUp"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 30.h, 8.w, 0),
                      child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();

                            Response response =
                                await dio.post('/account/login', data: fields);
                            User user = User.fromJson(response.data);

                            final userProvider =
                                Provider.of<UserModel>(context, listen: false);
                            userProvider.setUser = user;

                            debugPrint(response.data.toString());
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

    switch (response.data['message']) {
      case "Account needs verification":
        String email = response.data['payload']['email'];
        setSession(response);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => PinCodeVerificationScreen(email))));
        break;
      case "Login successful":
        setSession(response);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => MainPage())));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));

        break;
    }
  }

  void setSession(Response response) async {
    await SessionManager()
        .set('id', jsonEncode(response.data['payload']['id'].toString()));
    await SessionManager()
        .set('username', jsonEncode(response.data['payload']['username']));
  }
}
