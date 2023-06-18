import 'package:bigbelly/constants/colors.dart';
import 'package:bigbelly/constants/providers/nav_bar_visible.dart';
import 'package:bigbelly/screens/add_post/add_post_screen.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../mainPage/home_page.dart';
import '../recommendation/recommendation_screen.dart';
import 'tab_items.dart';

class NavBar extends ConsumerStatefulWidget {
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
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  List<BottomNavigationBarItem> items = [];
  bool isInstitution = false;
  @override
  void initState() {
    getIsInstitution();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navbar = ref.watch(navbarProvider);
    if (!navbar.isVisible) {
      return AddPostScreen();
    }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 70.h,
        activeColor: mainThemeColor,
        inactiveColor: const Color.fromARGB(255, 140, 204, 142),
        items: buildd(isInstitution),
        onTap: (index) {
          widget.onSelectedTab(TabItem.values[index]);
        },
      ),
      tabBuilder: (context, index) {
        final itemToBeShown = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: widget.navigatorKeys[itemToBeShown],
            builder: (context) {
              return widget.pageCreator[itemToBeShown]!;
            });
      },
    );
  }

  getIsInstitution() async {
    dynamic institution = await SessionManager().get("is_institutional");
    if (institution == true) {
      isInstitution = true;
    } else {
      isInstitution = false;
    }
    setState(() {});
  }
}

buildd(isInstitution) {
  if (isInstitution == true) {
    return [
      buildNavBarItem(TabItem.home),
      buildNavBarItem(TabItem.search),
      buildNavBarItem(TabItem.post),
      buildNavBarItem(TabItem.recommendation),
      buildNavBarItem(TabItem.menu),
    ];
  } else {
    return [
      buildNavBarItem(TabItem.home),
      buildNavBarItem(TabItem.search),
      buildNavBarItem(TabItem.post),
      buildNavBarItem(TabItem.recommendation),
    ];
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
