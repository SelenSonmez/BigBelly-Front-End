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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  static ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: notifier,
      builder: (_, mode, __) {
        return ScreenUtilInit(
          designSize: const Size(360, 732),
          builder: (context, child) {
            // darkMode.setMode = mode;
            // darkMode.setNotifier = _notifier;
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.green),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.green,
                ),
                themeMode: mode, // Decides which theme to show, light or dark.
                home: LoginScreen());
          },

          // child: MaterialApp(
          //   theme: ThemeData.light(),
          //   darkTheme: ThemeData.dark(),
          //   themeMode: mode, // Decides which theme to show, light or dark.
          //   home: LoginScreen(),
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
        );
      },
    );
    // return ScreenUtilInit(
    //     designSize: const Size(360, 732),
    //     builder: (BuildContext context, Widget? child) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(primarySwatch: Colors.green),
    //         home: LoginScreen(),
    //       );
    //     });
  }
}
