import 'package:bigbelly/constants/Dio.dart';
import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:bigbelly/screens/widgets/page_below_string.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/Colors.dart';

import '../helpers/BigBellyTextField.dart';
import '../helpers/field_regex.dart';
import '../login/LoginScreen.dart';
import 'texts.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {
    'name': null,
    'username': null,
    'email': null,
    'password': null
  };
  String errorMessage = "";

  Response? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(15.w),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 50.w),
              child: Hero(tag: "logo", child: logoImage)),
          Text(
              style: GoogleFonts.mulish(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: textFieldGray),
              "Sign Up"),
          BigBellyTextField(
            labelText: RegisterNameLabelText,
            hintText: RegisterNameHintText,
            icon: const Icon(Icons.account_circle_rounded),
            onSaved: (newValue) => fields['name'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) return NameCantBeEmpty;
            },
          ),
          BigBellyTextField(
            labelText: RegisterSurnameLabelText,
            hintText: RegisterSurnameHintText,
            icon: const Icon(Icons.family_restroom_rounded),
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Surname can't be empty";
            },
          ),
          BigBellyTextField(
            labelText: RegisterUsernameLabelText,
            hintText: RegisterUsernameHintText,
            icon: const Icon(Icons.alternate_email),
            onSaved: (newValue) => fields['username'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return UsernameCantBeEmpty;
              } else if (!userNameRegex.hasMatch(value))
                return UsernameNotValid;
            },
          ),
          BigBellyTextField(
            labelText: RegisterEmailLabelText,
            hintText: RegisterEmailHintText,
            icon: const Icon(Icons.mail_rounded),
            onSaved: (newValue) => fields['email'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty)
                return EmailCantBeEmpty;
              else if (!emailRegex.hasMatch(value)) return EmailNotValid;
            },
          ),
          BigBellyTextField(
            labelText: RegisterPasswordLabelText,
            hintText: RegisterPasswordHintText,
            icon: const Icon(Icons.lock_open_rounded),
            isPassword: true,
            isPwValidate: true,
            onSaved: (newValue) => fields['password'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return PasswordCantBeEmpty;
              } else if (!passwordRegex.hasMatch(value))
                return PasswordNotValid;
            },
          ),

          //Sign In Text
          PageBelowString(actionString: SignIn, longString: AlreadyHaveAccount),

          //Register Button
          ElevatedButton(
              onPressed: () async {
                _formKey.currentState!.save();
                if (!_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Please enter valid inputs")));
                } else {
                  response = await dio.post('/account/register', data: fields);

                  debugPrint(response!.data.toString());
                  if (response!.data['success']) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(response!.data['message'])));
                  }
                }
              },
              style: registerLoginButtonStyle,
              child: Text(
                "Register",
                style: registerLoginButtonTextStyle,
              ))
        ]),
      ),
    )));
  }
}
