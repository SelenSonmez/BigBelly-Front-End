import 'package:bigbelly/screens/add_post/add_post_screen.dart';
import 'package:bigbelly/screens/search/search_screen.dart';

import '../navbar/tab_items.dart';
import '../recommendation/recommendation_screen.dart';
import 'main_page_imports.dart';
import 'home_page.dart';

//which tab to show decider class
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TabItem _currentTab = TabItem.home;

  //to prevent exiting the app when hitting return button
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.post: GlobalKey<NavigatorState>(),
    TabItem.recommendation: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> allPages() {
    return {
      TabItem.home: const HomePage(),
      TabItem.search: const SearchScreen(),
      TabItem.post: const AddPostScreen(),
      TabItem.recommendation: const RecommendationScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: NavBar(
        currentTab: _currentTab,
        pageCreator: allPages(),
        navigatorKeys: navigatorKeys,
        onSelectedTab: (selectedTab) {
          setState(() {
            _currentTab = selectedTab;
          });
        },
      ),
    );
  }
}
