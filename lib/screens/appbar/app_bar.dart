import 'package:bigbelly/screens/follower_request/follower_request.dart';
import 'package:bigbelly/screens/profilePage/widgets/profile_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../constants/providers/user_provider.dart';
import '../authentication/model/user_model.dart';
import '../imports.dart';

class BigBellyAppBar extends ConsumerWidget {
  BigBellyAppBar(
      {super.key,
      this.trailingWidget = const CircleAvatar(
        backgroundImage: AssetImage('assets/images/defaultProfilePic.jpg'),
      )});

  Widget? trailingWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userProvider);
    return SliverAppBar(
        snap: true,
        collapsedHeight: 70.h,
        pinned: false,
        floating: true,
        backgroundColor: Colors.green,
        leadingWidth: 200.w,
        leading: SafeArea(
          child: Row(verticalDirection: VerticalDirection.up, children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: RichText(
                text: TextSpan(
                    text: "Big",
                    style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(color: Colors.black),
                        fontSize: 25.sp),
                    children: const [
                      TextSpan(
                          text: "Belly", style: TextStyle(color: Colors.white))
                    ]),
              ),
            ),
            Image.asset("assets/images/logoWithoutBackground.png")
          ]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: Icon(Icons.add_alert_sharp),
              iconSize: 35,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FollowerRequest()));
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: IconButton(
          //     icon: Icon(Icons.tag),
          //     iconSize: 35,
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => FollowerRequest()));
          //     },
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: GestureDetector(
              child: trailingWidget,
              onTap: () async {
                dynamic id = await SessionManager().get('id');
                Response info = await dio.get('/profile/$id/', data: id);
                print(info.data);
                User user = User.fromJson(info.data['payload']['user']);
                userValue.setUser = user;
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ProfilePage())));
              },
            ),
          ),
        ]);
  }
}
