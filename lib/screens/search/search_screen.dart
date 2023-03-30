// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/mainPage/main_page_imports.dart';
import 'package:bigbelly/screens/search/widgets/profile_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          BigBellyAppBar(
              trailingWidget: IconButton(
                  onPressed: () {},
                  icon: IconButton(
                    icon: Icon(size: 30.w, Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: BigBellySearchDelegate());
                    },
                  )))
        ];
      },
      body: Container(),
    ));
  }
}

class BigBellySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    "Selen",
    "Simge",
    "Elçin",
    "Kaan",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty)
              close(context, null);
            else
              query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null));
  }

  //searched and clicked profile of user will display
  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: Text(
      query,
      style: TextStyle(fontSize: 70.sp),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: ProfileTile(username: suggestion, followerCount: 232323),
            onTap: () {
              query = suggestion;

              showResults(context);
            },
          );
        });
  }
}
