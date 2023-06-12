import 'dart:io';

import 'package:bigbelly/constants/providers/meal_post_provider.dart';
import 'package:bigbelly/screens/imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealMenu extends ConsumerWidget {
  const MealMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var menuIngredient = ref.watch(mealPostProvider).getMenuIngredient;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu",
                  style: GoogleFonts.slabo27px(
                      color: Colors.green.shade800,
                      fontSize: 27,
                      letterSpacing: 2)),
              Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 8.0),
                        child: Text(menuIngredient.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // color: Colors.red,
                            width: 250,
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: menuIngredient.ingredients.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  menuIngredient.isMealHidden == false
                                      ? menuIngredient.ingredients[index] + ", "
                                      : "",
                                  style: TextStyle(fontSize: 15),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20),
                          // color: Colors.red,
                          // image: DecorationImage(
                          //   image: menuIngredient.imageUrl != null
                          //       ? AssetImage(menuIngredient.imageUrl!)
                          //       : AssetImage('assets/images/hamburger.jpg'),
                          //   fit: BoxFit.fill,
                          // ),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/hamburger.jpg')),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // image: menuIngredient.imageUrl != null
                        //     ? DecorationImage(
                        //         image: FileImage(
                        //             File(menuIngredient.imageUrl!)))
                        //     : DecorationImage(
                        //         image: AssetImage(
                        //             'assets/images/defaultProfilePic.jpg'),
                        //       )
                        // child: Image.asset('assets/images/hamburger.jpg')),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on,
                              color: Colors.green),
                          Text(menuIngredient.price.toString(),
                              style: TextStyle(fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.grey.shade300,
              )
            ],
          ),
        );
      },
    );
  }
}
