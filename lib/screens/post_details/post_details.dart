import 'package:bigbelly/screens/add_post/widgets/step_tile.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:bigbelly/screens/model/bigbelly_post_tag.dart';
import 'package:bigbelly/screens/model/ingredient.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../mainPage/main_page_imports.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  final List<Ingredient> ingredients = [
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: SingleChildScrollView(
          child: Column(children: [
        Image.asset('assets/images/hamburger.jpg'),
        Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                PostitleAndTags(),
                PostOwnerAndDate(),
                postReactions(),
                const Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                      style: GoogleFonts.slabo27px(fontSize: 17),
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                ),
                const Divider(thickness: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: [
                        Text("difficulty: ".toUpperCase(),
                            style: GoogleFonts.slabo27px(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 3)),
                        Text("Easy",
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
                    children: const [
                      _RecipeTimerIndicator(
                        time: "12 min",
                        title: "Preparation Time",
                      ),
                      _RecipeTimerIndicator(
                        time: "14 min",
                        title: "Baking Time",
                      )
                    ],
                  ),
                ),
                title("ingredients"),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("2 Servings",
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
                            "${ingredients[index].amount} (${ingredients[index].grams} g)   ${ingredients[index].amountType}",
                            style: GoogleFonts.slabo27px(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            ingredients[index].name,
                            style: GoogleFonts.slabo27px(fontSize: 20),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: ingredients.length,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("100 Calories",
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
                            message: "Estimated value. Not scientific measures",
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
                title("steps"),
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
                              "${steps[index].stepIndex}- ",
                              style: GoogleFonts.slabo27px(fontSize: 20),
                            ),
                          ),
                          Text(
                            steps[index].step,
                            style: GoogleFonts.slabo27px(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: steps.length,
                ),
                title("tags"),
                Wrap(
                  spacing: 10.w,
                  children: tags
                      .map((chip) => Chip(
                            avatar: const Icon(
                              Icons.flag_rounded,
                              color: Color.fromARGB(255, 18, 72, 5),
                            ),
                            labelStyle: TextStyle(fontSize: 15.sp),
                            key: ValueKey(chip.id),
                            label: Text(tags[chip.id].tagName),
                            backgroundColor: chip.id % 2 == 0
                                ? const Color.fromARGB(255, 159, 205, 164)
                                : const Color.fromARGB(255, 213, 232, 214),
                            padding: EdgeInsets.symmetric(
                                vertical: 7.h, horizontal: 10.w),
                          ))
                      .toList(),
                ),
                Text("Ingredients".toUpperCase()),
                Text("Ingredients".toUpperCase()),
                Text("Ingredients".toUpperCase()),
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
  const _RecipeTimerIndicator({required this.time, required this.title});
  final String time;
  final String title;
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
