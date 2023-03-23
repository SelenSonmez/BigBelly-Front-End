import 'package:bigbelly/screens/authentication/login/login_screen.dart';
import 'package:bigbelly/screens/verification/verification_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/screens/imports.dart';

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
    return ScreenUtilInit(
        designSize: const Size(360, 732),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.green),
            home: LoginScreen(),
          );
        });
  }
}
