import 'package:bigbelly/screens/imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/providers/user_provider.dart';

class FollowersPage extends ConsumerWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 35, title: const Text("Followers")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: valueUser.getUser.followers!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            AssetImage('assets/images/defaultProfilePic.jpg'),
                      ),
                      title:
                          Text(valueUser.getUser.followers![index].username!));
                }),
          ),
        ],
      ),
    );
  }
}
