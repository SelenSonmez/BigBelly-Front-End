import 'dart:async';

import 'package:bigbelly/constants/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/dio.dart';
import '../../../constants/styles.dart';
import '../../mainPage/main_page.dart';
import 'texts.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String email_address;

  const PinCodeVerificationScreen(this.email_address);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  int codeLength = 6;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30.h),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: Image.asset(logoImage),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Text(
                  EmailVerification,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 8.h),
                child: RichText(
                  text: TextSpan(
                      text: EnterCodeSentTo,
                      children: [
                        TextSpan(
                            text: widget.email_address,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15.sp)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0.h, horizontal: 10.w),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: codeLength,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < codeLength) {
                          return PleaseFillAllSpaces;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveFillColor: Colors.green.shade500,
                        inactiveColor: Colors.green.shade500,
                        selectedColor: Colors.green.shade100,
                        selectedFillColor: Colors.green.shade200,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 60.h,
                        fieldWidth: 50.w,
                        activeFillColor:
                            hasError ? Colors.red : Colors.green.shade300,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 20.sp, height: 1.6.h),
                      // backgroundColor: Colors.green.shade50,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 25,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                child: Text(
                  hasError ? "*$WrongCode" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //       text: DidntReceiveTheCode,
              //       style: TextStyle(color: Colors.black54, fontSize: 15.sp),
              //       children: [
              //         TextSpan(
              //             text: " ${Resend.toUpperCase()}",
              //             recognizer: onTapRecognizer,
              //             style: TextStyle(
              //                 color: const Color(0xFF91D3B3),
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16.sp))
              //       ]),
              // ),
              //Verify Button
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.w, 90.h, 30.w, 0.h),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5.h,
                            minimumSize: Size.fromHeight(50.h),
                            backgroundColor: mainThemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.w),
                            )),
                        onPressed: () async {
                          formKey.currentState?.validate();
                          // conditions for validating
                          dynamic id = await SessionManager().get('id');
                          Response response = await dio.post(
                              '/account/verificate',
                              data: {'id': id, 'code': currentText});
                          debugPrint(response.data.toString());
                          if (currentText.length != codeLength ||
                              !response.data['success']) {
                            errorController.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() {
                              hasError = true;
                              textEditingController.clear();
                            });
                          } else {
                            setState(() {
                              hasError = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(CodeMatched)));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => MainPage())));
                            });
                          }
                        },
                        child: Text(
                          Verify.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      textEditingController.clear();
                    },
                    child: Text(Clear,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
