import 'package:bigbelly/constants/providers/nav_bar_visible.dart';
import 'package:bigbelly/constants/providers/post_provider.dart';
import 'package:bigbelly/screens/add_post/add_post_screen.dart';
import 'package:bigbelly/screens/search/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../menu_post/post_meal_for_menu.dart';
import '../model/post.dart';
import '../navbar/tab_items.dart';
import '../recommendation/recommendation_screen.dart';
import 'main_page_imports.dart';
import 'home_page.dart';

//which tab to show decider class
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  TabItem _currentTab = TabItem.home;

  //to prevent exiting the app when hitting return button
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.post: GlobalKey<NavigatorState>(),
    TabItem.recommendation: GlobalKey<NavigatorState>(),
    TabItem.menu: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.home: HomePage(),
      TabItem.search: SearchScreen(),
      TabItem.post: AddPostScreen(),
      TabItem.recommendation: RecommendationScreen(),
      TabItem.menu: MenuPosts(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(postProvider);
    post.setPost(Post(
        steps: [], ingredients: [], tags: [], likeCount: 0, commentCount: 0));

    final navbar = ref.watch(navbarProvider);
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: NavBar(
        currentTab: _currentTab,
        pageCreator: allPages(),
        navigatorKeys: navigatorKeys,
        onSelectedTab: (selectedTab) {
          setState(() {
            switch (selectedTab) {
              case TabItem.post:
                navbar.setVisible = false;
                break;
              default:
                navbar.setVisible = true;
                break;
            }
            _currentTab = selectedTab;
          });
        },
      ),
    );
  }
}
