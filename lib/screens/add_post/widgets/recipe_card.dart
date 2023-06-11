import 'package:bigbelly/screens/add_post/translate.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/providers/post_provider.dart';
import '../../imports.dart';
import '../helpers/decoration.dart';

class RecipeCard extends ConsumerStatefulWidget {
  RecipeCard({
    super.key,
    required this.title,
    required this.explanation,
    this.isDoubleField = false,
  });

  String title;
  String explanation;
  bool? isDoubleField;

  @override
  ConsumerState<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends ConsumerState<RecipeCard> {
  final focusNode = FocusNode();
  var resultingDuration;
  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 17, 8, 17),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
        elevation: 10,
        shadowColor: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.all(18.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.w,
                        fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7.h),
                    width: 180.w,
                    height: 50.h,
                    child: Text.rich(
                      TextSpan(
                          text: widget.explanation,
                          style: TextStyle(color: Colors.grey.shade600)),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  widget.isDoubleField == true
                      ? Builder(
                          builder: (BuildContext context) =>
                              FloatingActionButton(
                            elevation: 10,
                            backgroundColor: Colors.green,
                            onPressed: () async {
                              resultingDuration = await showDurationPicker(
                                context: context,
                                initialTime: const Duration(seconds: 30),
                                baseUnit: BaseUnit.minute,
                              );
                              if (!mounted) return;

                              resultingDuration != null
                                  ? resultingDuration =
                                      "${resultingDuration.toString().split(':')[0]} : ${resultingDuration.toString().split(':')[1]}"
                                  : "";

                              widget.title == PreparationTime
                                  ? post.getPost.preparation_time =
                                      resultingDuration
                                  : post.getPost.baking_time =
                                      resultingDuration;

                              setState(() {});
                            },
                            tooltip: 'Popup Duration Picker',
                            child: const Icon(Icons.timer_outlined),
                          ),
                        )
                      : SizedBox(
                          width: 75,
                          height: 60,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            focusNode: focusNode,
                            onTapOutside: (event) => focusNode.unfocus(),
                            controller: TextEditingController(
                                text: post.getPost.portion),
                            onChanged: (value) => post.getPost.portion = value,
                            decoration: postTextFieldDecoration(Servings, "1"),
                          ),
                        ),
                  Text(
                    widget.title == BakingTime &&
                            post.getPost.baking_time != null
                        ? post.getPost.baking_time.toString()
                        : widget.title == PreparationTime &&
                                post.getPost.preparation_time != null
                            ? post.getPost.preparation_time.toString()
                            : "",
                    style: GoogleFonts.orbitron(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.green.shade900),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
