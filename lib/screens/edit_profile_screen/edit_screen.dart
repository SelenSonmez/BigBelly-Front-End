import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/Colors.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../constants/dio.dart';
import '../authentication/helpers/field_regex.dart';
import '../authentication/helpers/language_password_validator.dart';
import '../authentication/register/texts.dart';
import 'texts.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isNewPasswordAvailable = false;
  bool _isHiddenOld = true;
  bool _isHiddenNew = true;

  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic> fields = {
    'name': null,
    'old_password': null,
    'password': null
  };
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget placeText(String text) {
    //Content Text
    return Container(
      color: greyBackground,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(10.w),
              child: Text(text,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          EditProfileInformation,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle_rounded),
                        hintText: Name,
                        labelText: Name,
                      ),
                      onSaved: (String? value) {
                        fields['name'] = value;
                      },
                    ),
                    const SizedBox(width: 100.0, height: 60),
                    TextFormField(
                      obscureText: _isHiddenOld,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: OldPassword,
                        labelText: OldPassword,
                        //helperText: "Password must contain special character",
                        helperStyle: const TextStyle(color: Colors.red),
                        suffix: InkWell(
                          onTap: _togglePasswordViewOld,
                          child: Icon(
                            _isHiddenOld
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        fields['old_password'] = value;
                      },
                      validator: (value) {
                        if (fields['old_password'] == "" &&
                            fields['password'] != "")
                          return OldPasswordNotEmpty;
                      },
                    ),
                    const SizedBox(width: 100.0, height: 60),
                    TextFormField(
                      obscureText: _isHiddenNew,
                      controller: controller,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: NewPassword,
                        labelText: NewPassword,
                        //helperText: "Password must contain special character",
                        helperStyle: const TextStyle(color: Colors.red),
                        suffix: InkWell(
                          onTap: _togglePasswordViewNew,
                          child: Icon(
                            _isHiddenNew
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (fields['password'] == "" &&
                            fields['old_password'] != "")
                          return NewPasswordNotEmpty;
                        else if (!passwordRegex.hasMatch(value!))
                          return RequierementsNotMet;
                      },
                      onSaved: (String? value) {
                        fields['password'] = value;
                      },
                    ),
                    const SizedBox(width: 100.0, height: 10.0),
                    FlutterPwValidator(
                      strings: ValidatorLanguage(),
                      key: validatorKey,
                      controller: controller,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      //normalCharCount: 0,
                      width: 400,
                      height: 150,
                      onSuccess: () {
                        setState(() {
                          isNewPasswordAvailable = true;
                        });
                      },
                      onFail: () {
                        setState(() {
                          isNewPasswordAvailable = false;
                        });
                      },
                    ),
                    const SizedBox(width: 100.0, height: 40.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ElevatedButton(
                            onPressed: () async {
                              formKey.currentState!.save();
                              formKey.currentState!.validate();
                              dynamic id = await SessionManager().get('id');

                              final response = await dio.post(
                                  "/profile/$id/editProfile",
                                  data: fields);
                              print(response.data);
                              if (response.data['success'] == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(PleaseEnterValidInputs)));
                              } else {
                                final prefs =
                                    await SharedPreferences.getInstance();

                                prefs.setString("password", fields['password']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(EditingCorrect)));
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: Size.fromHeight(45.h),
                                backgroundColor: mainThemeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.w),
                                )),
                            child: Text(
                              Edit,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 40),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordViewOld() {
    setState(() {
      _isHiddenOld = !_isHiddenOld;
    });
  }

  void _togglePasswordViewNew() {
    setState(() {
      _isHiddenNew = !_isHiddenNew;
    });
  }
}
