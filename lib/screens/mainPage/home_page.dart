import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'main_page_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [const BigBellyAppBar()];
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
