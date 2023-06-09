import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/profilePage/widgets/texts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowingsPage extends ConsumerWidget {
  const FollowingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 35, title: Text(Following)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: userValue.getUser.followeds!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/defaultProfilePic.jpg'),
                      ),
                      title:
                          Text(userValue.getUser.followeds![index].username!));
                }),
          ),
        ],
      ),
    );
  }
}
