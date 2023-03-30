import 'package:bigbelly/screens/authentication/helpers/big_belly_text_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:im_stepper/stepper.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../imports.dart';
import 'widgets/big_belly_dropdown.dart';

import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreen createState() => _AddPostScreen();
}

class _AddPostScreen extends State<AddPostScreen> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.
  List pages = [];

  @override
  void initState() {
    pages.add(firstPage());
    pages.add(secondPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: mainThemeColor,
          title: Text('Create Recipe'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                icons: [
                  Icon(Icons.edit),
                  Icon(Icons.food_bank),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
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
              header(),
              Expanded(
                child: pages[activeStep],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  labelText: "Title"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text("Add a Recipe Photo".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  width: 350,
                  height: 330,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromARGB(255, 42, 102, 44)),
                      color: Color.fromARGB(255, 233, 243, 224),
                      borderRadius: BorderRadius.circular(18)),
                  child: Icon(Icons.add_a_photo_outlined,
                      size: 70, color: mainThemeColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget secondPage() {
    return Container(
      child: Text("alo"),
    );
  }

  Widget thirdPage() {
    return Container(
      child: Text("alo"),
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
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: mainThemeColor),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
        // decoration: BoxDecoration(
        //   color: Colors.orange,
        //   borderRadius: BorderRadius.circular(5),
        // ),
        // child: Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         headerText(),
        //         style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 20,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Title';
    }
  }
}
