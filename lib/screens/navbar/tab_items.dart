import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { home, search, post, recommendation }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> alltabs = {
    TabItem.home: TabItemData("home", Icons.home_outlined),
    TabItem.search: TabItemData("search", Icons.search),
    TabItem.post: TabItemData("post", Icons.add_circle_outline),
    TabItem.recommendation: TabItemData("recommendation", Icons.people_alt),
  };
}
