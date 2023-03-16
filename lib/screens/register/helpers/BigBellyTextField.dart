import 'package:flutter/material.dart';

import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/Colors.dart';

class BigBellyTextField extends StatefulWidget {
  BigBellyTextField(
      {super.key,
      this.labelText = "",
      this.hintText = "",
      this.icon,
      this.isPassword = false,
      this.isPwValidate = false,
      this.validator,
      this.onSaved});

  String labelText;
  String hintText;
  Icon? icon;
  bool isPassword;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;

  //checks if textfield contains password validation
  bool isPwValidate;

  bool? isTapped;

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  @override
  State<BigBellyTextField> createState() => _BigBellyTextField();
}

class _BigBellyTextField extends State<BigBellyTextField> {
  var focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    widget.isTapped = false;
    focusNode.addListener(() {
      setState(() {
        widget.isTapped = focusNode.hasFocus;
      });
    });
  }

  Widget placeTextField() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: TextFormField(
        controller: widget.controller,
        //If the text field contains confidential information
        obscureText: widget.isPassword == true ? true : false,

        decoration: InputDecoration(
          suffixIcon: widget.icon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textFieldGray,
              width: 1.5,
            ),
            borderRadius: textFieldCircleRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textFieldGray,
              width: 2.0,
            ),
            borderRadius: textFieldCircleRadius,
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
        focusNode: focusNode,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.isPwValidate
            ? Column(
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: placeTextField()),
                  widget.isTapped == true
                      ? FlutterPwValidator(
                          key: widget.validatorKey,
                          controller: widget.controller,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          numericCharCount: 1,
                          specialCharCount: 1,
                          normalCharCount: 3,
                          width: 370.w,
                          height: 150.h,
                          onSuccess: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text("Password is matched")));
                          },
                        )
                      : FlutterPwValidator(
                          width: 0,
                          height: 0,
                          minLength: 0,
                          onSuccess: () {},
                          controller: widget.controller),
                ],
              )
            : placeTextField());
  }
}
