// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bigbelly/screens/imports.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../helpers/page_below_string.dart';
import '../helpers/big_belly_text_field.dart';
import '../helpers/field_regex.dart';
import '../login/login_screen.dart';
import '../login/texts.dart';
import 'texts.dart';

Map<String, dynamic> fields = {
  'name': null,
  'username': null,
  'email': null,
  'password': null,
  'is_institutional': null
};

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isInstitution = false;

  Response? response;
  @override
  void initState() {
    // checkIfInstitution();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(15.w),
      child: Form(
        key: RegisterScreen._formKey,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Is institutional Account?",
                style: TextStyle(fontSize: 17),
              ),
              BigBellyCheckBox()
            ],
          ),
          //Sign In Text
          PageBelowString(
              actionString: SignIn,
              longString: AlreadyHaveAccount,
              type: "login"),

          //Register Button
          ElevatedButton(
              onPressed: () async {
                RegisterScreen._formKey.currentState!.save();
                if (!RegisterScreen._formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(PleaseEnterValidInputs)));
                } else {
                  response = await dio.post('/account/register', data: fields);
                  print("ALOOOO");
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

  checkIfInstitution() async {
    dynamic institution = await SessionManager().get("is_institutional");
    if (institution == true) {
      isInstitution = true;
    } else {
      isInstitution = false;
    }
  }
}

class BigBellyCheckBox extends StatefulWidget {
  const BigBellyCheckBox({super.key});

  @override
  State<BigBellyCheckBox> createState() => _BigBellyCheckBoxState();
}

class _BigBellyCheckBoxState extends State<BigBellyCheckBox> {
  bool isInstitution = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isInstitution,
        onChanged: (value) {
          setState(() {});
          isInstitution = value!;
          fields['is_institutional'] = isInstitution;
        });
  }
}
