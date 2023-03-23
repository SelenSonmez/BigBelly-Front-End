import 'package:bigbelly/screens/profilePage/widgets/profileHeader/follow_user.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_info.dart';
import '../../../imports.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/defaultProfilePic.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    UserFollowingStatus(),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ProfileInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
