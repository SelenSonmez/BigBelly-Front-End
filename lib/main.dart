import 'package:bigbelly/internationalization/text_decider.dart';
import 'package:bigbelly/repository/auth/login/login_repository.dart';
import 'package:bigbelly/screens/login/LoginScreen.dart';
import 'package:bigbelly/screens/login/widgets/form_widget.dart';
import 'package:bigbelly/screens/login/widgets/password_field.dart';
import 'package:bigbelly/screens/register/RegisterScreen.dart';
import 'package:bigbelly/screens/verification/verification_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Load language texts as preffed EN
  await TextDecider().setPreferredLanguage('EN').load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => LoginRepository()),
        Provider(create: (context) => LoginFormWidget()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 732),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.green),
              home: PinCodeVerificationScreen("selo"),
            );
          }),
    );
  }
}
