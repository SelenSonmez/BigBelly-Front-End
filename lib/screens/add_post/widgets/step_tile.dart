import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/providers/post_provider.dart';

class StepTile extends ConsumerStatefulWidget {
  StepTile({super.key, required this.step, required this.stepIndex});

  String step;
  int stepIndex;

  @override
  ConsumerState<StepTile> createState() => _StepTileState();

  static fromMap(Map<String, dynamic> x) {}

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'description': step};
  }

  static String listToMap(List<StepTile> list) {
    String name = "{";
    list.forEach((element) {
      name += "[description: ${element.step}],";
    });
    name += "}";
    return name;
  }
}

class _StepTileState extends ConsumerState<StepTile> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.step.toString();
  }

  @override
  Widget build(BuildContext context) {
    var post = ref.watch(postProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          title: Row(
            children: [
              Text("${widget.stepIndex}.  ",
                  style: const TextStyle(fontSize: 20)),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: null,
                  controller: controller,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (newValue) {
                    // post.getPost.steps![widget.stepIndex].step = newValue;
                    // post.getPost.steps![widget.stepIndex].stepIndex =
                    //     widget.stepIndex;
                    post.getPost.steps![widget.stepIndex - 1].step = newValue;
                    // post.getPost.steps!.add(StepTile(
                    //   step: newValue,
                    //   stepIndex: widget.stepIndex,
                    // ));
                    // post.getPost.steps![widget.stepIndex].step = newValue;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
