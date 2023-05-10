import 'dart:io';

import 'package:bigbelly/constants/providers/meal_post_provider.dart';
import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/model/menu_ingredient.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

import '../add_post/add_post_screen.dart';
import '../imports.dart';

class MenuPosts extends ConsumerStatefulWidget {
  MenuPosts({super.key});

  @override
  ConsumerState<MenuPosts> createState() => _MenuPostsState();
}

class _MenuPostsState extends ConsumerState<MenuPosts> {
  TextEditingController _controller = TextEditingController();

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mealIngredient = ref.watch(mealPostProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Create Menu Item")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20),
                child: TextFormField(
                  onSaved: (newValue) {
                    mealIngredient.getMenuIngredient.title = newValue!;
                  },
                  decoration: InputDecoration(labelText: "Meal Name"),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final files = await imageHelper.pickImage();
                  if (files.isNotEmpty) {
                    final croppedFile = await imageHelper.crop(
                      file: files.first,
                      cropStyle: CropStyle.rectangle,
                    );
                    if (croppedFile != null) {
                      setState(() => mealIngredient.getMenuIngredient.imageUrl =
                          croppedFile.path);
                    }
                  }
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: mealIngredient.getMenuIngredient.imageUrl.isEmpty
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.green)
                      : Image.file(
                          File(mealIngredient.getMenuIngredient.imageUrl)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        mealIngredient.getMenuIngredient.ingredients
                            .add(_controller.text);
                        setState(() {});
                      },
                      child: Icon(Icons.add)),
                  ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        String info = MenuIngredientToJson([
                          MenuIngredient(
                              imageUrl: "asddas",
                              price: mealIngredient.getMenuIngredient.price,
                              ingredients:
                                  mealIngredient.getMenuIngredient.ingredients,
                              isMealHidden:
                                  mealIngredient.getMenuIngredient.isMealHidden,
                              title: mealIngredient.getMenuIngredient.title)
                        ]);
                      },
                      child: const Icon(Icons.send)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: TextFormField(
                  onSaved: (newValue) {
                    mealIngredient.getMenuIngredient.price =
                        double.parse(newValue!);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: mealIngredient.getMenuIngredient.isMealHidden,
                    onChanged: (value) {
                      mealIngredient.getMenuIngredient.isMealHidden =
                          !mealIngredient.getMenuIngredient.isMealHidden;
                      setState(() {});
                    },
                  ),
                  const Text("Hide ingredients from users"),
                  Tooltip(
                    key: tooltipkey,
                    showDuration: const Duration(seconds: 2),
                    message:
                        "Ingredients are necessary for system to recommend users your menu. However you can hide it from users",
                    child: IconButton(
                      icon: Icon(Icons.question_mark),
                      onPressed: () {
                        tooltipkey.currentState?.ensureTooltipVisible();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: 200,
                  height: 500,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount:
                        mealIngredient.getMenuIngredient.ingredients.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                                onSaved: (newValue) {
                                  mealIngredient.getMenuIngredient
                                      .ingredients[index] = newValue!;
                                  // _controller.text = newValue!;
                                },
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    labelText: "Ingredient")),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                mealIngredient.getMenuIngredient.ingredients
                                    .removeAt(index);
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
