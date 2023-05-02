import 'package:bigbelly/constants/colors.dart';
import 'package:bigbelly/constants/providers/nav_bar_visible.dart';
import 'package:bigbelly/screens/add_post/add_post_screen.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mainPage/home_page.dart';
import 'tab_items.dart';

class NavBar extends ConsumerWidget {
  const NavBar(
      {super.key,
      required this.currentTab,
      required this.onSelectedTab,
      required this.pageCreator,
      required this.navigatorKeys});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pageCreator;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navbar = ref.watch(navbarProvider);
    if (!navbar.isVisible) {
      return AddPostScreen();
    }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 70.h,
        activeColor: mainThemeColor,
        inactiveColor: const Color.fromARGB(255, 140, 204, 142),
        items: [
          buildNavBarItem(TabItem.home),
          buildNavBarItem(TabItem.search),
          buildNavBarItem(TabItem.post),
          buildNavBarItem(TabItem.recommendation),
        ],
        onTap: (index) {
          onSelectedTab(TabItem.values[index]);
        },
      ),
      tabBuilder: (context, index) {
        final itemToBeShown = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: navigatorKeys[itemToBeShown],
            builder: (context) {
              return pageCreator[itemToBeShown]!;
            });
      },
    );
  }
}

BottomNavigationBarItem buildNavBarItem(TabItem tabItem) {
  final tabToBeCreated = TabItemData.alltabs[tabItem];
  return BottomNavigationBarItem(
    icon: Icon(
      tabToBeCreated!.icon,
      size: 35.h,
    ),
  );
}
