import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/liked_posts_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/saved_posts_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/user_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../../../constants/Colors.dart';
import '../../../../constants/providers/user_provider.dart';

class ProfileTabs extends ConsumerStatefulWidget {
  const ProfileTabs({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends ConsumerState<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int activeIndex = 0;
  bool isSelf = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    checkSelfID();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final userValue = ref.watch(userProvider);
    tabController.addListener(() {
      if (tabController.indexIsChanging ||
          tabController.animation!.value == tabController.index) {
        setState(() {
          activeIndex = tabController.index;
        });
      }
    });
    return Column(children: [
      TabBar(
        indicatorColor: mainThemeColor,
        indicatorWeight: 1.8,
        indicatorPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        controller: tabController,
        tabs: [
          Tab(
              icon: Icon(Icons.grid_on_outlined,
                  color: activeIndex == 0
                      ? mainThemeColor
                      : const Color.fromARGB(255, 140, 204, 142))),
          Tab(
            icon: Icon(Icons.favorite_border_sharp,
                color: activeIndex == 1
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142)),
          ),
          Tab(
              icon: Icon(Icons.bookmark_added_outlined,
                  color: activeIndex == 2
                      ? mainThemeColor
                      : const Color.fromARGB(255, 140, 204, 142))),
        ],
      ),
      Expanded(
        //width: 100,
        //height: 100,
        child: TabBarView(controller: tabController, children: [
          userValue.getUser.privacySetting!.isPrivate != null &&
                  (userValue.getUser.privacySetting!.isPrivate == true &&
                      !isSelf)
              ? const Center(
                  child: Expanded(
                    child: Icon(
                      Icons.lock_outline,
                      size: 55,
                    ),
                  ),
                )
              : const UserPosts(),
          const LikedPosts(),
          const SavedPosts()
        ]),
      )
    ]);
  }

  Future<bool> checkSelfID() async {
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');
    isSelf = (id == userValue.getUser.id.toString()) ? true : false;

    setState(() {});

    return isSelf;
  }
}
