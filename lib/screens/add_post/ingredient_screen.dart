import 'package:bigbelly/screens/model/database_ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchfield/searchfield.dart';

import '../../constants/providers/post_provider.dart';
import '../imports.dart';
import '../model/ingredient.dart';
import 'helpers/decoration.dart';

Future<List<DatabaseIngredient>> getIngredientList() async {
  Response response = await dio.get('/post/ingredients');
  var databaseIngredients = <DatabaseIngredient>[];
  response.data['payload']['ingredients'].forEach((v) {
    databaseIngredients.add(DatabaseIngredient.fromJson(v));
  });
  return databaseIngredients;
}

getList() async {
  ingredients = await getIngredientList();
}

List<DatabaseIngredient> ingredients = [];

class IngredientScreen extends ConsumerStatefulWidget {
  const IngredientScreen({super.key});

  @override
  ConsumerState<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends ConsumerState<IngredientScreen> {
  late Future<List<DatabaseIngredient>> databaseIngredients;
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;

  late String selectedIngredient = "Select Ingredient";

  late Ingredient ingredient;

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  final key = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _ingredients = getIngredientList();
    databaseIngredients = getIngredientList();
    ingredient = Ingredient(
        id: 0, name: "Select Ingredient", amount: "", amountType: "", grams: 0);
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getList();

    var post = ref.watch(postProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainThemeColor,
          title: const Text("Enter Ingredient"),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.shopping_bag),
            )
          ]),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: focusNode1,
                        onTapOutside: (event) => focusNode1.unfocus(),
                        onTap: () => focusNode1.requestFocus(),
                        onChanged: (value) {
                          ingredient.amount = value;
                        },
                        onSaved: (newValue) {
                          ingredient.amount = newValue;
                        },
                        decoration: postTextFieldDecoration("Amount", "1")),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      focusNode: focusNode2,
                      onTap: () => focusNode2.requestFocus(),
                      onTapOutside: (event) => focusNode2.unfocus(),
                      onSaved: (value) {
                        ingredient.amountType = value;
                      },
                      decoration:
                          postTextFieldDecoration("Scale", "Table Spoon"),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.h)),
                          side: BorderSide(width: 2.w, color: mainThemeColor)),
                      child: Text(
                        selectedIngredient,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: mainThemeColor),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            builder: (BuildContext context) {
                              return Form(
                                key: key,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      SearchField(
                                        suggestions: ingredients
                                            .map((e) => SearchFieldListItem(
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      e.name,
                                                      style: const TextStyle(
                                                          wordSpacing: 5,
                                                          color: Colors.green,
                                                          fontSize: 18),
                                                    )),
                                                e.name))
                                            .toList(),
                                        suggestionState: Suggestion.expand,
                                        textInputAction: TextInputAction.next,
                                        hint: "Type an Ingredient",
                                        hasOverlay: true,
                                        searchStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                        validator: (x) {
                                          if (x!.isNotEmpty) {
                                            selectedIngredient = x;
                                            setState(() {});
                                            Navigator.pop(context);
                                          } else {
                                            return "Enter a valid input";
                                          }
                                          // if (!ingredients.contains(x) ||
                                          //     x!.isEmpty) {
                                          // return 'Please Enter a valid State';
                                          // }
                                          // selectedIngredient = x;

                                          // return null;
                                        },
                                        searchInputDecoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.green),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                                color: Colors.red),
                                          ),
                                        ),
                                        maxSuggestionsInViewPort: 7,
                                        itemHeight: 50,
                                        onSuggestionTap: (x) {},
                                      ),
                                      Positioned(
                                        left: 300,
                                        top: 3,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.only(
                                                    right: 0),
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {
                                              key.currentState!
                                                  .validate()
                                                  .toString();
                                            },
                                            child: Icon(
                                              Icons.add,
                                              size: 35,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            context: context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Tooltip(
                  showDuration: const Duration(seconds: 2),
                  key: tooltipkey,
                  triggerMode: TooltipTriggerMode.manual,
                  message:
                      "If item is picked from the list enter grams for calorie calculation",
                  child: SizedBox(
                    width: 70.w,
                    child: TextFormField(
                      focusNode: focusNode3,
                      onTapOutside: (event) => focusNode3.unfocus(),
                      onChanged: (value) {
                        ingredient.grams = double.tryParse(value);
                      },
                      cursorColor: Colors.green,
                      keyboardType: TextInputType.number,
                      decoration: postTextFieldDecoration("Grams", "100"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 9.0.w),
                  child: const Text("g", style: TextStyle(fontSize: 17)),
                ),
                IconButton(
                  padding: EdgeInsets.only(top: 25.h),
                  icon:
                      Icon(Icons.question_mark, color: Colors.orange.shade900),
                  onPressed: () {
                    tooltipkey.currentState?.ensureTooltipVisible();
                  },
                ),
              ],
            ),

            //add ingredient button
            Padding(
              padding: EdgeInsets.only(top: 100.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100.w, 45.h),
                    backgroundColor: mainThemeColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.h))),
                onPressed: () {
                  _formKey.currentState!.save();
                  if (selectedIngredient == "Select Ingredient" ||
                      selectedIngredient.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red.shade400,
                      content: const Text('Please enter an ingredient name'),
                    ));
                  } else {
                    ingredient.name = selectedIngredient;
                    post.getPost.ingredients!.add(ingredient);
                    Navigator.pop(context, ingredient);
                  }
                },
                child: const Text("Add Ingredient",
                    style: TextStyle(fontSize: 24)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchIngredient extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
