import 'dart:convert';

import 'package:bigbelly/screens/settings/texts.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../imports.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String privacyButtonName = "Inprivate Account";
  bool _click = false;
  bool privacy = false;
  //returns title text in above contents
  Widget placeText(String text) {
    //Content Text
    return Container(
      color: greyBackground,
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
      color: Colors.white,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Colors.red.shade400,
                                            content: const Text(
                                                "Dil Türkçeye Çevrildi")));
                                    setState(() {});
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
                                  setState(() {});
                                }
                              },
                              child: Image.asset(
                                  height: 35, "assets/images/USA.png"),
                            ),
                          ],
                        ),
                      )),
                  placeTile(Icons.edit, EditProfile, true,
                      Icon(Icons.arrow_forward_ios_rounded)),

                  placeText(Privacy),
                  Container(
                    color: Colors.white,
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
                              debugPrint(response.data.toString());
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  // //Content Text Title
                  placeText(Content),

                  //Content
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        placeTile(Icons.favorite, "Favorites", true,
                            Icon(Icons.arrow_forward_ios_rounded)),
                        placeTile(Icons.star, "Collections", true,
                            Icon(Icons.arrow_forward_ios_rounded)),
                        placeTile(Icons.replay, "Re-cipes", true,
                            Icon(Icons.arrow_forward_ios_rounded)),
                        placeTile(Icons.bookmark_rounded, "Saved", true,
                            Icon(Icons.arrow_forward_ios_rounded)),
                      ],
                    ),
                  ),
                  placeText(Help),

                  Container(
                    color: Colors.white,
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
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: Size.fromHeight(32.h),
                            backgroundColor: mainThemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.w),
                            )),
                        child: Text(
                          "Log Out",
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
                            textStyle: const TextStyle(color: Colors.black),
                            fontSize: 25.sp),
                        children: const [
                          TextSpan(
                              text: "Belly",
                              style: TextStyle(color: Colors.green))
                        ]),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
