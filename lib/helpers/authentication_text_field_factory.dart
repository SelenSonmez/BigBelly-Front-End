import 'package:bigbelly/providers/password_field_validator_state_provider.dart';
import 'package:bigbelly/screens/login/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationTextField extends ConsumerWidget {
  AuthenticationTextField({Key? key, required this.parent}) : super(key: key);

  PasswordTextField parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool needToBeShown = ref.watch(passwordFieldValidatorStateProvider);
    return Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5), child: parent),
            needToBeShown && parent.isPwValidate
                ? FlutterPwValidator(
                    key: parent.validatorKey,
                    controller: TextEditingController(),
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    normalCharCount: 3,
                    width: 370.w,
                    height: 150.h,
                    onSuccess: () {},
                  )
                : FlutterPwValidator(
                    width: 0,
                    height: 0,
                    minLength: 0,
                    onSuccess: () {},
                    controller: TextEditingController()),
          ],
        ));
  }
}
