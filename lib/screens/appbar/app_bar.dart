import 'package:bigbelly/screens/profilePage/widgets/profile_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../constants/providers/user_provider.dart';
import '../authentication/model/user_model.dart';
import '../imports.dart';

class BigBellyAppBar extends ConsumerWidget {
  const BigBellyAppBar({super.key});

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
            padding: EdgeInsets.only(right: 10.0.w),
            child: GestureDetector(
              child: const CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/defaultProfilePic.jpg'),
              ),
              onTap: () async {
                dynamic id = await SessionManager().get('id');
                Response info = await dio.get('/profile/$id/', data: id);
                debugPrint(info.data['payload']['user'].toString());

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
