import 'package:bigbelly/screens/menu_post/post_meal_for_menu.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/collections/collections_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/liked_posts_page.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/meal_menu.dart';
import 'package:bigbelly/screens/profilePage/widgets/profileTabs/pages/user_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../../../constants/Colors.dart';
import '../../../../constants/providers/user_provider.dart';
import '../../../authentication/model/user_model.dart';
import 'pages/recipes.dart';

class ProfileTabs extends ConsumerStatefulWidget {
  ProfileTabs({Key? key, required this.isInsitution}) : super(key: key);
  bool isInsitution;

  @override
  ConsumerState<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends ConsumerState<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int activeIndex = 0;
  bool isSelf = false;
  bool isFollowing = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    checkSelfID();

    tabController =
        TabController(length: widget.isInsitution ? 4 : 3, vsync: this);
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
          tabs: showTabs(userValue)),
      Expanded(
        // width: 100,
        // height: 100,
        child:
            TabBarView(controller: tabController, children: getTabs(userValue)),
      )
    ]);
  }

  getTabs(var userValue) {
    if (userValue.getUser.isInstitution != null &&
        userValue.getUser.isInstitution == true) {
      [
        userValue.getUser.privacySetting!.isPrivate != null &&
                (userValue.getUser.privacySetting!.isPrivate == true &&
                    !isSelf &&
                    isFollowing)
            ? const Center(
                child: Expanded(
                  child: Icon(
                    Icons.lock_outline,
                    size: 55,
                  ),
                ),
              )
            : UserPosts(isUserSelf: isSelf),
        CollectionsTab(),
        const Recipes(),
        MealMenu()
      ];
    } else {
      return [
        userValue.getUser.privacySetting!.isPrivate != null &&
                (userValue.getUser.privacySetting!.isPrivate == true &&
                    !isSelf &&
                    isFollowing)
            ? const Center(
                child: Expanded(
                  child: Icon(
                    Icons.lock_outline,
                    size: 55,
                  ),
                ),
              )
            : UserPosts(isUserSelf: isSelf),
        CollectionsTab(),
        const Recipes(),
      ];
    }
  }

  Future<bool> checkSelfID() async {
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');
    isSelf = (id == userValue.getUser.id.toString()) ? true : false;

    setState(() {});

    return isSelf;
  }

  void checkIsFollowing() async {
    final userValue = ref.read(userProvider);
    final id = await SessionManager().get('id');

    for (User user in userValue.getUser.followers!) {
      if (user.id == id) {
        isFollowing = true;
      }
    }
    setState(() {});
  }

  List<Widget> showTabs(var userValue) {
    if (userValue.getUser.isInstitution != null &&
        userValue.getUser.isInstitution == true) {
      return [
        Tab(
            icon: Icon(Icons.grid_on_outlined,
                color: activeIndex == 0
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142))),
        Tab(
          icon: Icon(Icons.bookmarks,
              color: activeIndex == 1
                  ? mainThemeColor
                  : const Color.fromARGB(255, 140, 204, 142)),
        ),
        Tab(
            icon: Icon(Icons.replay,
                color: activeIndex == 2
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142))),
        Tab(
            icon: Icon(Icons.menu_book,
                color: activeIndex == 3
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142)))
      ];
    } else {
      return [
        Tab(
            icon: Icon(Icons.grid_on_outlined,
                color: activeIndex == 0
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142))),
        Tab(
          icon: Icon(Icons.bookmarks,
              color: activeIndex == 1
                  ? mainThemeColor
                  : const Color.fromARGB(255, 140, 204, 142)),
        ),
        Tab(
            icon: Icon(Icons.replay,
                color: activeIndex == 2
                    ? mainThemeColor
                    : const Color.fromARGB(255, 140, 204, 142))),
      ];
    }
  }
}
