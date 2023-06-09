import 'package:bigbelly/screens/profilePage/widgets/profileHeader/follow_user.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/providers/user_provider.dart';
import '../../../imports.dart';

class ProfileHeader extends ConsumerWidget {
  ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userProvider);
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
                  children: [
                    Text(
                      value.getUser.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const UserFollowingStatus(),
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
