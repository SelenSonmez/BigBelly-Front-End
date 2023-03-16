import 'package:bigbelly/constants/Dio.dart';
import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/Colors.dart';

import '../login/LoginScreen.dart';
import 'helpers/BigBellyTextField.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {
    'name': null,
    'username': null,
    'email': null,
    'password': null
  };

  // username consists of alphanumberic chars. lower or uppercase
  // username allowed of the dot and underscore but no consecutively. e.g: flutter..regex
  // they can't be used as first or last char.
  // length must be between 5-20
  final userNameRegex =
      RegExp(r'^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$');
  // https://www.w3resource.com/javascript/form/email-validation.php
  final emailRegex = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');

  final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\?$&*~.]).{8,}$');
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
            labelText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Name')
                .target('LabelText')
                .decideText(),
            hintText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Name')
                .target('HintText')
                .decideText(),
            icon: const Icon(Icons.account_circle_rounded),
            onSaved: (newValue) => fields['name'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) return "Name can't be empty";
            },
          ),
          BigBellyTextField(
            labelText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Surname')
                .target('LabelText')
                .decideText(),
            hintText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Surname')
                .target('HintText')
                .decideText(),
            icon: const Icon(Icons.family_restroom_rounded),
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Surname can't be empty";
            },
          ),
          BigBellyTextField(
            labelText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Username')
                .target('LabelText')
                .decideText(),
            hintText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Username')
                .target('HintText')
                .decideText(),
            icon: const Icon(Icons.alternate_email),
            onSaved: (newValue) => fields['username'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username can't be empty";
              } else if (!userNameRegex.hasMatch(value))
                return "username not matched";
            },
          ),
          BigBellyTextField(
            labelText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Email')
                .target('LabelText')
                .decideText(),
            hintText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Email')
                .target('HintText')
                .decideText(),
            icon: const Icon(Icons.mail_rounded),
            onSaved: (newValue) => fields['email'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Email can't be empty";
              else if (!emailRegex.hasMatch(value)) return "Email not valid";
            },
          ),
          BigBellyTextField(
            labelText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Password')
                .target('LabelText')
                .decideText(),
            hintText: TextDecider()
                .goOnPath('RegisterScreen')
                .goOnPath('Password')
                .target('HintText')
                .decideText(),
            icon: const Icon(Icons.lock_open_rounded),
            isPassword: true,
            isPwValidate: true,
            onSaved: (newValue) => fields['password'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password can't be empty";
              } else if (!passwordRegex.hasMatch(value))
                return "Password not Valid";
            },
          ),

          //Sign In Text
          Container(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    style: TextStyle(fontSize: 16.sp),
                    "Already have an account?  "),
                TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 143, 160, 78))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),

          //Register Button
          ElevatedButton(
              onPressed: () async {
                _formKey.currentState!.save();
                if (!_formKey.currentState!.validate()) {
                  debugPrint("geldi");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Please enter valid inputs")));
                } else {
                  Response response =
                      await dio.post('/account/register', data: fields);

                  debugPrint(response.data.toString());
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginScreen())));
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
                "Register",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ))
        ]),
      ),
    )));
  }
}
