import 'package:bigbelly/constants/Dio.dart';
import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constants/Colors.dart';

import '../login/LoginScreen.dart';
import '../helpers/BigBellyTextField.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {
    'name': null,
    'username': null,
    'email': null,
    'password': null
  };

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
              onSaved: (newValue) => fields['name'] = newValue),
          BigBellyTextField(
            labelText: "Surname",
            hintText: "Surname",
            icon: const Icon(Icons.family_restroom_rounded),
          ),
          BigBellyTextField(
              labelText: "Username",
              hintText: "Username",
              icon: const Icon(Icons.alternate_email),
              onSaved: (newValue) => fields['username'] = newValue),
          BigBellyTextField(
              labelText: "Email",
              hintText: "Email",
              icon: const Icon(Icons.mail_rounded),
              onSaved: (newValue) => fields['email'] = newValue),
          BigBellyTextField(
              labelText: "Password",
              hintText: "Password",
              icon: const Icon(Icons.lock_open_rounded),
              isPassword: true,
              isPwValidate: true,
              onSaved: (newValue) => fields['password'] = newValue),

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

                Response response =
                    await dio.post('/account/register', data: fields);

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
