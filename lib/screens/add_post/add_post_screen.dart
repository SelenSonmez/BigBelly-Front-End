import 'dart:convert';
import 'dart:io';

import 'package:bigbelly/constants/providers/nav_bar_visible.dart';
import 'package:bigbelly/screens/authentication/login/login_screen.dart';
import 'package:bigbelly/screens/recommendation/recommendation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../constants/providers/post_provider.dart';
import '../imports.dart';

import '../model/bigbelly_post_tag.dart';
import '../model/ingredient.dart';
import '../model/post.dart';
import 'helpers/decoration.dart';
import 'helpers/image_helper.dart';
import 'ingredient_screen.dart';
import 'widgets/recipe_card.dart';
import 'widgets/step_tile.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  AddPostScreen({super.key});
  @override
  _AddPostScreen createState() => _AddPostScreen();
}

final imageHelper = ImageHelper();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddPostScreen extends ConsumerState<AddPostScreen> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  int upperBound = 5; // upperBound MUST BE total number of icons minus 1.
  List pages = [];
  @override
  void initState() {
    super.initState();
    pages.add(const _FirstPage());
    pages.add(const _SecondPage());
    pages.add(const _ThirdPage());
    pages.add(const FourthPage());
    pages.add(const FifthPage());
    pages.add(const _SixthPage());
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(postProvider);
    final navbar = ref.watch(navbarProvider);
    navbar.setVisible = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainThemeColor,
          title: Text(_changeAppBarTitle(activeStep)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                stepColor: Colors.green.shade100,
                activeStepBorderColor: Colors.green.shade200,
                activeStepBorderWidth: 1.5,
                lineColor: const Color.fromARGB(255, 52, 123, 54),
                icons: const [
                  Icon(Icons.camera_alt),
                  Icon(Icons.access_alarm),
                  Icon(Icons.food_bank_rounded),
                  Icon(Icons.edit),
                  Icon(Icons.flag),
                  Icon(Icons.tag_sharp),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              // header(),
              Expanded(
                child: pages[activeStep],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  Column(
                    children: [
                      activeStep == 5
                          ? createPostButton(
                              post.getPost.title, post.getPost.imageURL)
                          : nextButton(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: mainThemeColor),
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: const Text('Next'),
    );
  }

  Widget createPostButton(title, image) {
    final navbar = ref.watch(navbarProvider);
    return Builder(builder: (context) {
      var post = ref.watch(postProvider);
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: mainThemeColor),
        onPressed: () async {
          if (title == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please enter title")));
          } else if (image == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please pick an image")));
          } else {
            dynamic id = await SessionManager().get('id');

            var steps = [];
            post.getPost.steps!.forEach((element) {
              steps.add({'description': element.step});
            });
            var ingredients = [];

            post.getPost.ingredients!.forEach((e) {
              ingredients.add({
                'ingredient_id': e.id,
                'ingredient_name': e.name,
                'amount': e.amount,
                'unit': e.amountType,
                'gram': e.grams
              });
            });
            var tags = [];

            post.getPost.tags!.forEach((e) {
              tags.add({'name': e.tagName});
            });

            FormData image = FormData.fromMap({
              "file": await MultipartFile.fromFile(post.getPost.imageURL!),
            });

            Map<String, dynamic> fields = {
              "account_id": id,
              'title': post.getPost.title,
              'description': post.getPost.description,
              'difficulty': post.getPost.difficulty,
              'portion': post.getPost.portion,
              "preparation_time": post.getPost.preparation_time,
              "baking_time": post.getPost.baking_time,
              "steps": steps,
              "ingredients": ingredients,
              "tags": tags,
            };

            Response response =
                await dio.post("/post/create", data: jsonEncode(fields));
            await dio.post("/post/${response.data['payload']['post_id']}/image",
                data: image);

            debugPrint(response.data.toString());
            navbar.setVisible = true;

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainPage()));
          }
        },
        child: const Text('Create Post'),
      );
    });
  }

  /// Returns the previous button.
  Widget previousButton() {
    final navbar = ref.watch(navbarProvider);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: mainThemeColor),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        } else {
          navbar.setVisible = true;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        }
      },
      child: const Text('Prev'),
    );
  }
}

class _FirstPage extends ConsumerStatefulWidget {
  const _FirstPage({super.key});

  @override
  ConsumerState<_FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends ConsumerState<_FirstPage> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Form(
                child: TextFormField(
                    key: _formKey,
                    focusNode: focusNode,
                    onTapOutside: (event) => focusNode.unfocus(),
                    controller: TextEditingController(text: post.getPost.title),
                    onChanged: (value) => post.getPost.title = value,
                    decoration:
                        postTextFieldDecoration("Title *", "Juicy Hamburger"),
                    validator: (value) =>
                        (value == "") ? "Please enter a title" : ""),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0.h),
                  child: Text("Add a Recipe Photo *".toUpperCase(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                //pick a photo
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: GestureDetector(
                    child: Container(
                        width: 350.w,
                        height: 350.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.w,
                              color: const Color.fromARGB(255, 42, 102, 44)),
                          color: const Color.fromARGB(255, 233, 243, 224),
                        ),
                        child: post.getPost.imageURL != null
                            ? FittedBox(
                                fit: BoxFit.fill,
                                child: Image.file(File(post.getPost.imageURL!)))
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
                          setState(
                              () => post.getPost.imageURL = croppedFile.path);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondPage extends ConsumerStatefulWidget {
  const _SecondPage({super.key});

  @override
  ConsumerState<_SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<_SecondPage> {
  final List<bool> _selectedDifficulty = <bool>[true, false, false];
  bool isSelected = false;
  static const List<Widget> difficulty = <Widget>[
    Text('Easy'),
    Text('Medium'),
    Text('Hard')
  ];

  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    return Center(
      child: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ToggleButtons(
            borderColor: Colors.green,
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < _selectedDifficulty.length; i++) {
                  _selectedDifficulty[i] = i == index;
                }
              });
              post.getPost.difficulty =
                  _selectedDifficulty.indexOf(true).toString();
            },
            borderRadius: BorderRadius.all(Radius.circular(8.h)),
            selectedBorderColor: Colors.green[700],
            selectedColor: Colors.white,
            fillColor: Colors.green[200],
            color: Colors.green[400],
            constraints: BoxConstraints(
              minHeight: 45.0.h,
              minWidth: 100.0.w,
            ),
            isSelected: [
              post.getPost.difficulty == "0",
              post.getPost.difficulty == "1",
              post.getPost.difficulty == "2"
            ],
            children: difficulty,
          ),
          RecipeCard(
            title: "Portion",
            explanation: "Enter how much servings your recipe consists",
            textFieldLabel: "Servings",
          ),
          RecipeCard(
            title: "Preparation Time",
            explanation: "How much it takes to prepare this recipe?",
            textFieldLabel: "hour",
            secondTextFieldLabel: "min",
            isDoubleField: true,
          ),
          RecipeCard(
            title: "Baking Time",
            explanation: "How much it takes to bake this recipe?",
            textFieldLabel: "hour",
            secondTextFieldLabel: "min",
            isDoubleField: true,
          ),
        ]),
      ),
    );
  }
}

class _ThirdPage extends ConsumerStatefulWidget {
  const _ThirdPage({super.key});

  @override
  ConsumerState<_ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends ConsumerState<_ThirdPage> {
  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    var steps = post.getPost.steps!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          elevation: 10.h,
          backgroundColor: mainThemeColor,
          onPressed: () {
            _showBottomAddStep();
          },
          child: Icon(Icons.add, size: 35.h)),
      body: Center(
          child: steps.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Dismissible(
                                background: Padding(
                                  padding: EdgeInsets.all(8.0.h),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.h)),
                                    color: Colors.red.shade400,
                                    child: const ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text("Removing Step",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ),
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  int i = 1;
                                  debugPrint(index.toString());
                                  steps.removeAt(index);

                                  debugPrint(steps.toString());
                                  for (StepTile tile in steps) {
                                    tile.stepIndex = i;
                                    i++;
                                  }
                                  setState(() {});
                                },
                                child:
                                    steps != null ? steps[index] : Text("alo"),
                              );
                            },
                            itemCount: steps.length),
                      ),
                    ],
                  ),
                )
              : Text("Let the world know your tricks!",
                  style: TextStyle(fontSize: 18.sp))),
    );
  }

  void _showBottomAddStep() {
    var post = ref.watch(postProvider);
    var steps = post.getPost.steps!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              //gives space according to the space when the keyboard is visible
              bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: TextStyle(fontSize: 20.sp),
              decoration: const InputDecoration(
                  hintText: "Enter your step!", border: InputBorder.none),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                steps.add(StepTile(step: value, stepIndex: steps.length + 1));
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }
}

class FourthPage extends ConsumerWidget {
  const FourthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var post = ref.watch(postProvider);
    return Center(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(30.0.h),
          child: TextField(
              controller: TextEditingController(text: post.getPost.description),
              maxLines: 8,
              cursorColor: Colors.green,
              onChanged: (value) => post.getPost.description = value,
              decoration: postTextFieldDecoration(
                  "Enter description to your recipe", "")),
        )
      ]),
    );
  }
}

class FifthPage extends ConsumerStatefulWidget {
  const FifthPage({super.key});

  @override
  ConsumerState<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends ConsumerState<FifthPage> {
  Ingredient? ingredient;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          post.getPost.ingredients!.isEmpty
              ? Text("Enter the Ingredients!",
                  style: TextStyle(fontSize: 20.sp))
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.h)),
                            color: Colors.red.shade400,
                            child: const ListTile(
                              leading: Icon(Icons.delete),
                              title: Text("Removing Step",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          post.getPost.ingredients!.removeAt(index);
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0.h),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.h)),
                            elevation: 5,
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                        "${post.getPost.ingredients![index].amount}"),
                                    Text(
                                        textAlign: TextAlign.center,
                                        post.getPost.ingredients![index]
                                            .amountType
                                            .toString()),
                                    Text(
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        post.getPost.ingredients![index].name),
                                    post.getPost.ingredients![index].grams != 0
                                        ? Text(
                                            "|  ${post.getPost.ingredients![index].grams} g")
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: post.getPost.ingredients!.length,
                  ),
                )
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.h)),
        backgroundColor: mainThemeColor,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const IngredientScreen()));

          if (!mounted) return;
          setState(() {});
        },
        label: Row(
          children: [
            const Icon(Icons.add_circle_rounded),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Text(
                "Enter Ingredient",
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SixthPage extends ConsumerStatefulWidget {
  const _SixthPage({super.key});

  @override
  ConsumerState<_SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends ConsumerState<_SixthPage> {
  void _deleteChip(String id, var postTags) {
    setState(() {
      postTags.removeWhere((element) => element.id == id);
      // _allTags.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var postTags = ref.watch(postProvider).getPost.tags;
    return Scaffold(
      body: postTags!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Tags to Categorize Your Recipe!",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(15.h),
              child: Wrap(
                spacing: 10.w,
                children: postTags
                    .map((chip) => Chip(
                        avatar: const Icon(
                          Icons.flag_rounded,
                          color: Color.fromARGB(255, 18, 72, 5),
                        ),
                        labelStyle: TextStyle(fontSize: 18.sp),
                        key: ValueKey(chip.id),
                        label: Text(postTags[chip.id].tagName),
                        backgroundColor: chip.id % 2 == 0
                            ? const Color.fromARGB(255, 159, 205, 164)
                            : const Color.fromARGB(255, 213, 232, 214),
                        padding: EdgeInsets.symmetric(
                            vertical: 7.h, horizontal: 10.w),
                        deleteIconColor: Colors.red,
                        onDeleted: () => setState(() {
                              postTags.removeAt(chip.id);
                            })))
                    .toList(),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainThemeColor,
        onPressed: postTags.length != 10
            ? _showBottomTagModalSheet
            : _chipLengthExceedError,
        child: Icon(
          Icons.add,
          size: 35.h,
        ),
      ),
    );
  }

  void _showBottomTagModalSheet() {
    var post = ref.watch(postProvider);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              //gives space according to the space when the keyboard is visible
              bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                  hintText: "Enter your tag!", border: InputBorder.none),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                post.getPost.tags!.add(BigBellyPostTag(
                    tagName: value, id: post.getPost.tags!.length));
                // _allTags.add(BigBellyPostTag(
                //     tagName: value, id: _allTags.length.toString()));
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _chipLengthExceedError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap the button to proceed
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tag Limit Reached'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('The maximum tag limit is 10'),
                Text('No more can be added'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: mainThemeColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

String _changeAppBarTitle(int pageIndex) {
  switch (pageIndex) {
    case 0:
      return "Create Recipe";
    case 1:
      return "Enter Timings";
    case 2:
      return "Enter Steps";
    case 3:
      return "Enter Description";
    case 4:
      return "Enter Ingredients";
    case 5:
      return "Enter Tags";
    default:
      return "Page Title Not Entered";
  }
}
