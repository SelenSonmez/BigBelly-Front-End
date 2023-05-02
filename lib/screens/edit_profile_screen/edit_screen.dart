import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/Colors.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool _isHidden = true;
  final TextEditingController controllerOld = TextEditingController();
  final TextEditingController controllerNew = TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                /* Container(
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height) / 9,
                    color: mainThemeColor,
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 40.w),
                      child: Text(
                          style: GoogleFonts.mulish(
                              color: Colors.white,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                          "Edit profile information"),
                    )),*/
                Container(
                  //top: ((MediaQuery.of(context).size.height) / 9.7),
                  //left: 0,
                  //right: 0,
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle_rounded),
                        hintText: 'Name*',
                        labelText: 'Name',
                      ),
                      onSaved: (String? value) {},
                    ),
                    const SizedBox(width: 100.0, height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.family_restroom_rounded),
                        hintText: 'Surname*',
                        labelText: 'Surname',
                      ),
                      onSaved: (String? value) {},
                    ),
                    const SizedBox(width: 100.0, height: 20),
                    TextFormField(
                      obscureText: _isHidden,
                      controller: controllerOld,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: 'Old Password*',
                        labelText: 'Old Password',
                        //helperText: "Password must contain special character",
                        helperStyle: const TextStyle(color: Colors.red),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 100.0, height: 20),
                    TextFormField(
                      obscureText: _isHidden,
                      controller: controllerNew,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.password_outlined),
                        hintText: 'New Password*',
                        labelText: 'New Password',
                        //helperText: "Password must contain special character",
                        helperStyle: const TextStyle(color: Colors.red),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 100.0, height: 10.0),
                    FlutterPwValidator(
                      key: validatorKey,
                      controller: controllerNew,
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
                      },
                      onFail: () {
                        print("NOT MATCHED");
                      },
                    ),
                    const SizedBox(width: 100.0, height: 20.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ElevatedButton(
                            onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
