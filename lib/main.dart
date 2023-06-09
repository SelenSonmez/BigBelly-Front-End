import 'package:bigbelly/screens/authentication/login/login_screen.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:bigbelly/screens/follower_request/follower_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/imports.dart';
import 'screens/add_post/add_post_screen.dart';
import 'constants/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Load language texts as preffed EN
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('language') == "TR") {
    await TextDecider().setPreferredLanguage('TR').load();
  } else {
    await TextDecider().setPreferredLanguage('EN').load();
  }
  runApp(const ProviderScope(child: MyApp()));
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
