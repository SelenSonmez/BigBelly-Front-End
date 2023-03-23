import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/liked_posts_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/saved_posts_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/user_posts_page.dart';
import 'package:flutter/material.dart';
import '../../../../constants/Colors.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({Key? key, required this.isPrivate}) : super(key: key);
  final bool isPrivate;

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int activeIndex = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
          widget.isPrivate
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
}
