// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bigbelly/constants/providers/user_provider.dart';
import 'dart:convert';

import 'package:bigbelly/screens/authentication/verification/verification_screen.dart';
import 'package:bigbelly/screens/imports.dart';

import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:bigbelly/screens/recommendation/recommendation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/providers/currentUser_provider.dart';
import '../model/user_model.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../helpers/page_below_string.dart';
import '../register/texts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key, this.notifier, this.mode}) : super(key: key);
  ThemeMode? mode;
  ValueNotifier<ThemeMode>? notifier;
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {'username': null, 'password': null};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // home: Scaffold(
            //   body: Center(
            //     child: ElevatedButton(
            //       onPressed: () => _notifier.value =
            //           mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
            //       child: Text('Toggle Theme'),
            //     ),
            //   ),
            // ),
            // ),
            Hero(tag: "logo", child: Image.asset(logoImage)),
            Text(
              SignIn,
              style: GoogleFonts.mulish(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: textFieldGray),
            ),
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
                        actionString: SignUp,
                        longString: DontHaveAccount,
                        type: "signUp"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.w, 30.h, 8.w, 0),
                      child: ElevatedButton(
                          onPressed: () async {
                            formKey.currentState!.save();
                            login(context, ref);
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

  Future login(context, ref) async {
    Response response = await dio.post('/account/login', data: fields);

    switch (response.data['message']) {
      case "Account needs verification":
        String email = response.data['payload']['email'];
        setSession(response);
        sendEmail(
            to_email: email,
            name: fields['username'],
            email: "selensonmez2001@gmail.com",
            subject: "Verification Code",
            message: response.data['payload']['code'].toString());

        print("NNNNNNNNNN" + response.data['payload']['code'].toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => PinCodeVerificationScreen(email))));
        break;
      case "Login successful":
        final prefs = await SharedPreferences.getInstance();
        // prefs.setString("username", fields['username']);
        print("pw" + fields['password']);
        prefs.setString("password", fields['password']);
        var userID = ref.watch(userIDProvider);
        userID.setUserID = response.data['payload']['id'];
        setSession(response);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const MainPage())));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(response.data['message'])));

        break;
    }
  }

  void setSession(Response response) async {
    await SessionManager()
        .set('id', jsonEncode(response.data['payload']['id'].toString()));
    await SessionManager()
        .set('username', jsonEncode(response.data['payload']['username']));
    await SessionManager()
        .set('privacy', jsonEncode(response.data['payload']['privacy']));
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String to_email,
  }) async {
    final serviceID = 'service_reomxzb';
    final templateID = 'template_k0cgsde';
    final userID = '-SFDvk8X6DfzqOwEn';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceID,
          'template_id': templateID,
          'user_id': userID,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': to_email,
            'user_subject': subject,
            'user_message': message
          }
        }));
    print(response.body);
  }
}
