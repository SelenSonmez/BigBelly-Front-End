// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bigbelly/screens/imports.dart';

import '../helpers/page_below_string.dart';
import '../helpers/big_belly_text_field.dart';
import '../helpers/field_regex.dart';
import '../login/login_screen.dart';
import '../login/texts.dart';
import 'texts.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> fields = {
    'name': null,
    'username': null,
    'email': null,
    'password': null
  };

  Response? response;

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
              child: Hero(tag: "logo", child: Image.asset(logoImage))),
          Text(
            SignUp,
            style: GoogleFonts.mulish(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: textFieldGray),
          ),
          BigBellyTextField(
            labelText: RegisterNameLabelText,
            hintText: RegisterNameHintText,
            icon: const Icon(Icons.account_circle_rounded),
            onSaved: (newValue) => fields['name'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) return NameCantBeEmpty;
            },
          ),
          BigBellyTextField(
            labelText: RegisterSurnameLabelText,
            hintText: RegisterSurnameHintText,
            icon: const Icon(Icons.family_restroom_rounded),
            validator: (value) {
              if (value == null || value.isEmpty) return SurnameCantBeEmpty;
            },
          ),
          BigBellyTextField(
            labelText: RegisterUsernameLabelText,
            hintText: RegisterUsernameHintText,
            icon: const Icon(Icons.alternate_email),
            onSaved: (newValue) => fields['username'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return UsernameCantBeEmpty;
              } else if (!userNameRegex.hasMatch(value))
                return UsernameNotValid;
            },
          ),
          BigBellyTextField(
            labelText: RegisterEmailLabelText,
            hintText: RegisterEmailHintText,
            icon: const Icon(Icons.mail_rounded),
            onSaved: (newValue) => fields['email'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty)
                return EmailCantBeEmpty;
              else if (!emailRegex.hasMatch(value)) return EmailNotValid;
            },
          ),
          BigBellyTextField(
            labelText: RegisterPasswordLabelText,
            hintText: RegisterPasswordHintText,
            icon: const Icon(Icons.lock_open_rounded),
            isPassword: true,
            isPwValidate: true,
            onSaved: (newValue) => fields['password'] = newValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return PasswordCantBeEmpty;
              } else if (!passwordRegex.hasMatch(value))
                return PasswordNotValid;
            },
          ),

          //Sign In Text
          PageBelowString(
              actionString: SignIn,
              longString: AlreadyHaveAccount,
              type: "login"),

          //Register Button
          ElevatedButton(
              onPressed: () async {
                _formKey.currentState!.save();
                if (!_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Please enter valid inputs")));
                } else {
                  response = await dio.post('/account/register', data: fields);

                  debugPrint(response!.data.toString());
                  if (response!.data['success']) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(response!.data['message'])));
                  }
                }
              },
              style: registerLoginButtonStyle,
              child: Text(
                Register,
                style: registerLoginButtonTextStyle,
              ))
        ]),
      ),
    )));
  }
}
