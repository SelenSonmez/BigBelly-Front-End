import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/followers_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/following_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/texts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/providers/user_provider.dart';
import '../../../mainPage/main_page_imports.dart';

class ProfileInfo extends ConsumerStatefulWidget {
  const ProfileInfo({super.key});

  @override
  ConsumerState<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends ConsumerState<ProfileInfo> {
  late int postCount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userValue = ref.watch(userProvider);
    updatePostCount(userValue);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
            onPressed: () {},
            child: Consumer(builder: (context, ref, child) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(userValue.getUser.postCount.toString(),
                        style: const TextStyle(fontSize: 17)),
                    Text(Posts, style: const TextStyle(fontSize: 15))
                  ]);
            })),
        divider(),
        MaterialButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: ((context) => const FollowersPage())));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(userValue.getUser.followers!.length.toString(),
                    style: const TextStyle(fontSize: 17)),
                Text(Followers, style: const TextStyle(fontSize: 15))
              ]),
        ),
        divider(),
        MaterialButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: ((context) => const FollowingsPage())));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(userValue.getUser.followeds!.length.toString(),
                    style: const TextStyle(fontSize: 17)),
                Text(Following, style: const TextStyle(fontSize: 15))
              ]),
        )
      ],
    );
  }

  Widget divider() => const SizedBox(
        height: 25,
        child: VerticalDivider(
          thickness: 1,
        ),
      );

  void updatePostCount(UserModel userValue) {
    userValue.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
