import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_page_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [BigBellyAppBar()];
        },
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      return Column(children: [
                        Image.asset('assets/images/hamburger.jpg'),
                        Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: const [
                                PostitleAndTags(),
                                PostOwnerAndDate(),
                                postReactions(),
                                Divider(thickness: 2)
                              ],
                            )),
                      ]);
                    }, childCount: 10),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
