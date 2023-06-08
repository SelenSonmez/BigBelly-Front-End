import 'package:bigbelly/screens/add_post/widgets/step_tile.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/model/bigbelly_post_tag.dart';
import 'package:bigbelly/screens/model/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mainPage/main_page_imports.dart';
import '../model/post.dart';
import 'texts.dart';

class PostDetails extends ConsumerWidget {
  PostDetails({super.key, required this.post, required this.index});
  Post post;
  int index;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  List<Ingredient> ingredients = [
    Ingredient(
        id: 1,
        name: "Agara",
        amount: "1",
        amountType: "Table Spoon",
        grams: 100),
    Ingredient(
        id: 1,
        name: "Sirdan",
        amount: "1/2",
        amountType: "Tea Spoon",
        grams: 100),
    Ingredient(
        id: 1,
        name: "Un",
        amount: "1/4",
        amountType: "Table Spoon",
        grams: 100),
    Ingredient(
        id: 1,
        name: "Carrot",
        amount: "3/2",
        amountType: "Table Spoon",
        grams: 100),
  ];
  List<StepTile> steps = [
    StepTile(
      step: "Unu koy",
      stepIndex: 1,
    ),
    StepTile(
      step: "Sekeri cirp",
      stepIndex: 2,
    ),
    StepTile(
      step: "Tereyagini erit",
      stepIndex: 3,
    ),
    StepTile(
      step: "karistir hepsini",
      stepIndex: 4,
    ),
  ];
  List<BigBellyPostTag> tags = [
    BigBellyPostTag(tagName: "Vegan", id: 0),
    BigBellyPostTag(tagName: "Gluten", id: 1),
    BigBellyPostTag(tagName: "Asgksla", id: 2),
    BigBellyPostTag(tagName: "aksjfsa", id: 3),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String difficulty = None;
    if (post.difficulty != null) {
      switch (post.difficulty) {
        case "0":
          difficulty = Easy;
          break;
        case "1":
          difficulty = Medium;
          break;
        case "2":
          difficulty = Hard;
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(Details)),
      body: SingleChildScrollView(
          child: Column(children: [
        Image.network(post.imageURL!),
        Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                PostitleAndTags(post: post),
                PostOwnerAndDate(post: post),
                postReactions(
                  post: post,
                  index: index,
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                      style: GoogleFonts.slabo27px(fontSize: 17),
                      post.description != null ? post.description! : ""),
                ),
                const Divider(thickness: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: [
                        Text("$Difficulty ".toUpperCase(),
                            style: GoogleFonts.slabo27px(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 3)),
                        Text(difficulty,
                            style: GoogleFonts.slabo27px(
                              fontSize: 19,
                              letterSpacing: 1.5,
                            )),
                      ])),
                ),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _RecipeTimerIndicator(
                        time: post.preparation_time != null
                            ? post.preparation_time!
                            : "00",
                        title: PreparationTime,
                      ),
                      _RecipeTimerIndicator(
                        time:
                            post.baking_time != null ? post.baking_time! : "00",
                        title: BakingTime,
                      )
                    ],
                  ),
                ),
                title(Ingredients),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        post.portion != null
                            ? "${post.portion!} $Servings"
                            : "",
                        style: GoogleFonts.slabo27px(
                            fontSize: 19, color: mainThemeColor))),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${post.ingredients![index].amount} (${post.ingredients![index].grams} g)   ${ingredients[index].amountType}",
                            style: GoogleFonts.slabo27px(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            post.ingredients![index].name,
                            style: GoogleFonts.slabo27px(fontSize: 20),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: post.ingredients!.length,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("100 $Calories",
                          style: GoogleFonts.slabo27px(fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50)),
                          child: Tooltip(
                            key: tooltipkey,
                            triggerMode: TooltipTriggerMode.tap,
                            message: EstimatedValue,
                            child: ClipOval(
                              child: IconButton(
                                padding: EdgeInsets.all(1),
                                iconSize: 20,
                                icon: const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  tooltipkey.currentState
                                      ?.ensureTooltipVisible();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title(Steps),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${index + 1}- ",
                              style: GoogleFonts.slabo27px(fontSize: 20),
                            ),
                          ),
                          Text(
                            post.steps![index].step,
                            style: GoogleFonts.slabo27px(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: post.steps!.length,
                ),
                title(Tags),
                Wrap(
                  spacing: 10.w,
                  children: post.tags!
                      .map((chip) => Chip(
                            avatar: const Icon(
                              Icons.flag_rounded,
                              color: Color.fromARGB(255, 18, 72, 5),
                            ),
                            labelStyle: TextStyle(fontSize: 15.sp),
                            key: ValueKey(chip.id),
                            label: Text(chip.tagName),
                            backgroundColor: chip.id % 2 == 0
                                ? const Color.fromARGB(255, 159, 205, 164)
                                : const Color.fromARGB(255, 213, 232, 214),
                            padding: EdgeInsets.symmetric(
                                vertical: 7.h, horizontal: 10.w),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            )),
      ])),
    );
  }

  Widget title(String title) {
    return Column(
      children: [
        const Divider(
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.slabo27px(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecipeTimerIndicator extends StatelessWidget {
  _RecipeTimerIndicator({required this.time, required this.title});
  String time;
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.green.shade200,
                border: Border.all(color: Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(50)),
            child: Align(
                alignment: Alignment.center,
                child: Text(time,
                    style: GoogleFonts.slabo27px(
                        textStyle: const TextStyle(
                            color: Colors.black, fontSize: 19)))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(title,
                style: GoogleFonts.slabo27px(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 19))),
          ),
        ],
      ),
    );
  }
}
