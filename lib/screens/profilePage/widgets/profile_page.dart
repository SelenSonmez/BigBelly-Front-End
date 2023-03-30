import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileHeader/profile_header.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/profile_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/providers/user_provider.dart';
import '../../authentication/model/user_model.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            userValue.getUser.privacySetting!.isPrivate != null &&
                    userValue.getUser.privacySetting!.isPrivate == true
                ? const Icon(
                    Icons.lock_outline,
                  )
                : Container(),
            Text(userValue.getUser.username!),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        //backgroundColor: const Color.fromARGB(255, 140, 204, 142),
      ),
      body: SafeArea(
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [ProfileHeader()];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ProfileTabs(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}