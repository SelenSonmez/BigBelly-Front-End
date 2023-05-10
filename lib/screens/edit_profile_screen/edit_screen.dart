import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/Colors.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../authentication/helpers/field_regex.dart';
import '../authentication/register/texts.dart';

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
    'oldPassword': null,
    'newPassword': null
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
        title: const Text(
          'Edit profile information',
        ),
        centerTitle: true,
      ),
      //resizeToAvoidBottomInset: true,

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
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle_rounded),
                        hintText: 'Name*',
                        labelText: 'Name',
                      ),
                      onSaved: (String? value) {
                        fields['name'] = value;
                        debugPrint(fields['name']);
                      },
                    ),
                    const SizedBox(width: 100.0, height: 60),
                    TextFormField(
                      obscureText: _isHiddenOld,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: 'Old Password*',
                        labelText: 'Old Password',
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
                        fields['oldPassword'] = value;
                        debugPrint(fields['oldPassword']);
                      },
                      validator: (value) {
                        if (fields['oldPassword'] == "" &&
                            fields['newPassword'] != "")
                          return "Old Password can not be empty.";
                      },
                    ),
                    const SizedBox(width: 100.0, height: 60),
                    TextFormField(
                      obscureText: _isHiddenNew,
                      controller: controller,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: 'New Password*',
                        labelText: 'New Password',
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
                        if (fields['newPassword'] == "" &&
                            fields['oldPassword'] != "")
                          return "New Password can not be empty.";
                        else if (!passwordRegex.hasMatch(value!))
                          return PasswordNotValid;
                      },
                      onSaved: (String? value) {
                        fields['newPassword'] = value;
                        debugPrint(fields['newPassword']);
                      },
                    ),
                    const SizedBox(width: 100.0, height: 10.0),
                    FlutterPwValidator(
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
                        print("MATCHED");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Password is matched")));
                        setState(() {
                          isNewPasswordAvailable = true;
                        });
                      },
                      onFail: () {
                        print("NOT MATCHED");
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
                            onPressed: () {
                              formKey.currentState!.save();
                              formKey.currentState!.validate();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: Size.fromHeight(45.h),
                                backgroundColor: mainThemeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.w),
                                )),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
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
