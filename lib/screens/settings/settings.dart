import '../imports.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String privacyButtonName = "Inprivate Account";
  bool _click = false;
  bool light = true;
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

  //return tile that consists of icon, text, iconbutton
  Widget placeTile(
      IconData icon, String text, Widget trailingWidget, bool clickable) {
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
              trailing: trailingWidget,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height) / 4.5,
                  color: mainThemeColor,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                        style: GoogleFonts.mulish(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                        "Settings"),
                  )),
            ],
          ),
          Positioned(
              top: ((MediaQuery.of(context).size.height) / 9.7),
              left: 0,
              right: 0,
              child: Column(
                children: [
                  //Hello Text
                  placeText("Account"),

                  placeTile(
                      Icons.restore_from_trash_rounded,
                      "Archived Recipes",
                      Icon(Icons.arrow_forward_ios_rounded),
                      true),
                  placeTile(Icons.language, "Language",
                      Icon(Icons.arrow_forward_ios_rounded), true),

                  placeText("Privacy"),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        placeTile(
                            Icons.lock,
                            privacyButtonName,
                            Switch(
                              // This bool value toggles the switch.
                              value: light,
                              activeColor: Colors.green,
                              onChanged: (bool value) async {
                                setState(() {
                                  if (value == true) {
                                    privacyButtonName = "Private Account";
                                  } else {
                                    privacyButtonName = "InPrivate Account";
                                  }
                                  light = value;
                                });
                                Response response =
                                    await dio.post("/profile/1/edit");
                              },
                            ),
                            false)
                      ],
                    ),
                  ),

                  // //Content Text Title
                  placeText("Content"),

                  //Content
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        placeTile(Icons.favorite, "Favorites",
                            Icon(Icons.arrow_forward_ios_rounded), true),
                        placeTile(Icons.star, "Collections",
                            Icon(Icons.arrow_forward_ios_rounded), true),
                        placeTile(Icons.replay, "Re-cipes",
                            Icon(Icons.arrow_forward_ios_rounded), true),
                        placeTile(Icons.bookmark_rounded, "Saved",
                            Icon(Icons.arrow_forward_ios_rounded), true),
                      ],
                    ),
                  ),
                  placeText("Help"),

                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        placeTile(Icons.help_outline, "Report",
                            Icon(Icons.arrow_forward_ios_rounded), true),
                        placeTile(Icons.live_help_rounded, "About BigBelly",
                            Icon(Icons.arrow_forward_ios_rounded), true),
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
