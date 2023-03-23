import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/followers_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/following_page.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {},
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("10", style: TextStyle(fontSize: 17)),
                Text("Posts", style: TextStyle(fontSize: 15))
              ]),
        ),
        divider(),
        MaterialButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: ((context) => const FollowersPage())));
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("150", style: TextStyle(fontSize: 17)),
                Text("Followers", style: TextStyle(fontSize: 15))
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
              children: const [
                Text("150", style: TextStyle(fontSize: 17)),
                Text("Following", style: TextStyle(fontSize: 15))
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
}
