import 'dart:convert';

import 'package:bigbelly/screens/authentication/login/login_screen.dart';
import 'package:bigbelly/screens/authentication/login/texts.dart';
import 'package:bigbelly/screens/authentication/register/register_screen.dart';
import 'package:bigbelly/screens/follower_request/follower_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/imports.dart';
import 'constants/providers/currentUser_provider.dart';
import 'screens/add_post/add_post_screen.dart';
import 'constants/providers/user_provider.dart';
import 'screens/recommendation/recommendation_screen.dart';

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
            return FutureBuilder(
              future: isSignedIn(ref),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(primarySwatch: Colors.green),
                      darkTheme: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.green,
                      ),
                      themeMode:
                          mode, // Decides which theme to show, light or dark.
                      home: snapshot.data);
                } else {
                  return Stack(
                    textDirection: TextDirection.rtl,
                    children: [
                      Image.asset("assets/images/frameBig.png"),
                    ],
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Future<Widget> isSignedIn(ref) async {
    dynamic isINstitution = await SessionManager().get("is_institutional");
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("username") != null) {
      var username = prefs.getString("username");
      username = username!.substring(1, username!.length - 1);
      Response response = await dio.post('/account/login', data: {
        'username': username,
        'password': prefs.getString("password")
      });
      var userID = ref.watch(userIDProvider);
      userID.setUserID = response.data['payload']['id'];
      setSession(response);
      return MainPage();
    } else {
      return LoginScreen();
    }
  }

  void setSession(Response response) async {
    await SessionManager()
        .set('id', jsonEncode(response.data['payload']['id'].toString()));
    await SessionManager()
        .set('username', jsonEncode(response.data['payload']['username']));
    await SessionManager()
        .set('privacy', jsonEncode(response.data['payload']['privacy']));
    await SessionManager().set('is_institutional',
        jsonEncode(response.data['payload']['is_institutional']));
  }
}
