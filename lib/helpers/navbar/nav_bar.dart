import 'package:bigbelly/constants/Colors.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../screens/mainPage/home_page.dart';
import 'tab_items.dart';

class NavBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 70,
        activeColor: mainThemeColor,
        inactiveColor: Color.fromARGB(255, 140, 204, 142),
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
      size: 35,
    ),
  );
}
