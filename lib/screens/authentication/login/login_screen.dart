import 'package:bigbelly/screens/imports.dart';

import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:bigbelly/screens/verification/verification_screen.dart';

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
                        actionString: SignUp, longString: DontHaveAccount),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 30.h, 8.w, 0),
                      child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();

                            if (!formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(PleaseEnterValidInputs)));
                            } else {
                              Response response = await dio
                                  .post('/account/login', data: fields);

                              switch (response.data['message']) {
                                case "Account needs verification":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              PinCodeVerificationScreen(response
                                                  .data["payload"]['email']))));
                                  break;
                                case "Login successful":
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => MainPage())));
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text(response.data['message'])));

                                  break;
                              }
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
}
