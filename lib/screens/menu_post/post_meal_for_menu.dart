import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/constants/providers/meal_post_provider.dart';
import 'package:bigbelly/constants/providers/user_provider.dart';
import 'package:bigbelly/screens/model/menu_ingredient.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:image_cropper/image_cropper.dart';

import '../add_post/add_post_screen.dart';
import '../imports.dart';
import '../recommendation/recommendation_screen.dart';
import 'texts.dart';

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
      appBar: AppBar(title: Text(CreateMenuItem)),
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
                  decoration: InputDecoration(labelText: MealName),
                ),
              ),
              GestureDetector(
                child: Container(
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.w,
                          color: const Color.fromARGB(255, 42, 102, 44)),
                      color: const Color.fromARGB(255, 233, 243, 224),
                    ),
                    child: mealIngredient.getMenuIngredient.imageUrl != ""
                        ? FittedBox(
                            fit: BoxFit.fill,
                            child: Image.file(File(
                                mealIngredient.getMenuIngredient.imageUrl!)))
                        : Icon(Icons.add_a_photo_outlined,
                            size: 70.h, color: mainThemeColor)),
                onTap: () async {
                  final files = await imageHelper.pickImage();
                  if (files.isNotEmpty) {
                    final croppedFile = await imageHelper.crop(
                      file: files.first,
                      cropStyle: CropStyle.rectangle,
                    );
                    if (croppedFile != null) {
                      mealIngredient.getMenuIngredient.imageUrl =
                          croppedFile.path;
                      final filePath =
                          mealIngredient.getMenuIngredient.imageUrl;
                      final lastIndex =
                          filePath!.lastIndexOf(new RegExp(r'.jp'));
                      final splitted = filePath.substring(0, (lastIndex));
                      final outPath =
                          "${splitted}_out${filePath.substring(lastIndex)}";
                      var result =
                          await FlutterImageCompress.compressAndGetFile(
                              mealIngredient.getMenuIngredient.imageUrl!,
                              outPath,
                              quality: 25);
                      setState(() {
                        mealIngredient.getMenuIngredient.imageUrl = outPath;
                      });
                    }
                  }
                },
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
                      child: const Icon(Icons.add)),
                  ElevatedButton(
                      onPressed: () async {
                        dynamic id = await SessionManager().get("id");

                        _formKey.currentState!.save();

                        List<dynamic> ingredients = [];

                        mealIngredient.getMenuIngredient.ingredients.map(
                            (e) => ingredients.add({'ingredient_name': e}));

                        Map<String, dynamic> params = {
                          'account_id': id,
                          'title': mealIngredient.getMenuIngredient.title,
                          'price': mealIngredient.getMenuIngredient.price,
                          'is_hidden':
                              mealIngredient.getMenuIngredient.isMealHidden,
                          'steps': [],
                          'tags': [],
                          'ingredients': ingredients,
                        };

                        FormData image = FormData.fromMap({
                          "file": await MultipartFile.fromFile(
                              mealIngredient.getMenuIngredient.imageUrl!),
                        });

                        final response = await dio.post('/post/create',
                            data: jsonEncode(params));
                        await dio.post(
                            "/post/${response.data['payload']['post_id']}/image",
                            data: image);
                        logger.i(response.data);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Meal Has Created")));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
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
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: Price),
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
                  Text(HideIngredients),
                  Tooltip(
                    key: tooltipkey,
                    showDuration: const Duration(seconds: 2),
                    message: IngredientsAreNecc,
                    child: IconButton(
                      icon: const Icon(Icons.question_mark),
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
                                decoration:
                                    InputDecoration(labelText: Ingredient)),
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
