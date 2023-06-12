import 'dart:convert';
import 'package:bigbelly/screens/settings/texts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../main.dart';
import '../edit_profile_screen/edit_screen.dart';
import '../imports.dart';

class Setting extends ConsumerStatefulWidget {
  Setting({Key? key, this.notifier, this.mode}) : super(key: key);
  ThemeMode? mode;
  ValueNotifier<ThemeMode>? notifier;
  @override
  ConsumerState<Setting> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  String privacyButtonName = "Inprivate Account";
  bool _click = false;
  bool privacy = false;
  //returns title text in above contents
  Widget placeText(String text) {
    //Content Text
    return Container(
      // color: Colors.grey.shade200,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(10.w),
              child: Text(text,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  @override
  void initState() {
    getPrivacy();
    super.initState();
  }

  Future<bool> getPrivacy() async {
    privacy = await SessionManager().get('privacy');
    setState(() {});
    return privacy;
  }

  //return tile that consists of icon, text, iconbutton
  Widget placeTile(
    IconData icon,
    String text,
    bool clickable,
    Widget trailingWidget,
  ) {
    return Container(
      width: 500,
      height: 45,
      // color: Colors.white,
      child: clickable == true
          ? GestureDetector(
              child: ListTile(
                leading: Icon(icon, color: iconColor),
                title: Text(
                  text,
                  style: TextStyle(fontSize: 15.sp),
                ),
                trailing: trailingWidget,
              ),
              onTap: () {},
            )
          : ListTile(
              leading: Icon(icon, color: iconColor),
              title: Text(
                text,
                style: TextStyle(fontSize: 13.sp),
              ),
              trailing: trailingWidget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Settings,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                //height: (MediaQuery.of(context).size.height) / 4.5,
              ),
            ],
          ),
          Positioned(
              //top: ((MediaQuery.of(context).size.height) / 9.7),
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    //Hello Text
                    placeText(Account),

                    placeTile(
                      Icons.restore_from_trash_rounded,
                      ArchivedRecipe,
                      true,
                      Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    placeTile(
                        Icons.language,
                        Langugae,
                        true,
                        SizedBox(
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    Feedback.forTap(context);
                                    await TextDecider()
                                        .setPreferredLanguage('TR')
                                        .load();
                                    if (TextDecider()
                                            .goOnPath('MainPage')
                                            .target('Report')
                                            .decideText() ==
                                        "Raporla") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.red.shade400,
                                              content: const Text(
                                                  "Dil Türkçeye Çevrildi")));

                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.remove('language');
                                      await prefs.setString('language', "TR");
                                      setState(() {});
                                      SystemNavigator.pop();
                                    }
                                  },
                                  child: Image.asset(
                                      height: 35,
                                      "assets/images/turkish_flag.png")),
                              GestureDetector(
                                onTap: () async {
                                  Feedback.forTap(context);
                                  await TextDecider()
                                      .setPreferredLanguage('EN')
                                      .load();
                                  if (TextDecider()
                                          .goOnPath('MainPage')
                                          .target('Report')
                                          .decideText() ==
                                      "Report") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.blueAccent.shade400,
                                            content: Text(
                                                "Language Has Changed To English")));
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.remove('language');
                                    await prefs.setString('language', "EN");
                                    setState(() {});
                                    SystemNavigator.pop();
                                  }
                                },
                                child: Image.asset(
                                    height: 35, "assets/images/USA.png"),
                              ),
                            ],
                          ),
                        )),
                    placeTile(
                        Icons.edit,
                        EditProfile,
                        true,
                        IconButton(
                          padding: EdgeInsets.only(left: 25.w),
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditScreen(),
                                ));
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: placeTile(
                        Icons.sunny,
                        "Theme",
                        true,
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 28.0),
                          child: LiteRollingSwitch(
                            //initial value
                            value: MyApp.notifier.value == ThemeMode.light
                                ? true
                                : false,
                            width: 100,
                            textOn: 'Light',
                            textOff: 'Dark',
                            colorOn: Colors.green,
                            colorOff: Colors.black,
                            iconOn: Icons.sunny,
                            iconOff: Icons.dark_mode,
                            textSize: 15.0,
                            onChanged: (bool state) {
                              //Use it to manage the different states
                              if (state == true) {
                                MyApp.notifier.value = ThemeMode.light;
                                // darkMode.notifier.value = ThemeMode.light;
                                // darkMode.setNotifier =
                                //     ValueNotifier(ThemeMode.dark);
                              } else if (state == false) {
                                MyApp.notifier.value = ThemeMode.dark;
                              }
                              setState(() {});
                            },

                            onDoubleTap: () {},
                            onSwipe: () {},
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),

                    placeText(Privacy),
                    Container(
                      // color: Colors.white,
                      child: Column(
                        children: [
                          placeTile(
                            Icons.lock,
                            PrivateAccount,
                            false,
                            Switch(
                              // This bool value toggles the switch.
                              value: privacy,
                              activeColor: Colors.green,
                              onChanged: (bool value) async {
                                setState(() {
                                  privacy = value;
                                });
                                await SessionManager().set('privacy', value);
                                dynamic id = await SessionManager().get('id');

                                Response response = await dio.post(
                                    "/profile/$id/edit",
                                    data: {"privacy_setting": value ? 1 : 0});
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    // //Content Text Title
                    // placeText(Content),

                    // //Content
                    // Container(
                    //   color: Colors.white,
                    //   child: Column(
                    //     children: [
                    //       placeTile(Icons.star, Collections, true,
                    //           Icon(Icons.arrow_forward_ios_rounded)),
                    //       placeTile(Icons.replay, Recipes, true,
                    //           Icon(Icons.arrow_forward_ios_rounded)),
                    //     ],
                    //   ),
                    // ),
                    placeText(Help),

                    Container(
                      // color: Colors.white,
                      child: Column(
                        children: [
                          placeTile(Icons.help_outline, Report, true,
                              Icon(Icons.arrow_forward_ios_rounded)),
                          placeTile(
                            Icons.live_help_rounded,
                            AboutBigBelly,
                            true,
                            Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 100.0, height: 10.0),

                    //Log Out button
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              minimumSize: Size(330.w, 40.h),
                              backgroundColor: mainThemeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.w),
                              )),
                          child: Text(
                            LogOut,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          )),
                    ),

                    const SizedBox(width: 100.0, height: 35.0),

                    RichText(
                      text: TextSpan(
                          text: "Big",
                          style: GoogleFonts.patrickHand(
                              fontSize: 25.sp,
                              textStyle: TextStyle(
                                  color: MyApp.notifier.value == ThemeMode.dark
                                      ? Colors.white
                                      : Colors.black)),
                          children: const [
                            TextSpan(
                                text: "Belly",
                                style: TextStyle(color: Colors.green))
                          ]),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
