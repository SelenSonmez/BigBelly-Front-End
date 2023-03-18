import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BigBellyAppBar extends StatelessWidget {
  const BigBellyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        snap: true,
        collapsedHeight: 70.h,
        pinned: false,
        floating: true,
        backgroundColor: Colors.green,
        leadingWidth: 200.w,
        leading: SafeArea(
          child: Row(verticalDirection: VerticalDirection.up, children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: RichText(
                text: TextSpan(
                    text: "Big",
                    style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(color: Colors.black),
                        fontSize: 25.sp),
                    children: const [
                      TextSpan(
                          text: "Belly", style: TextStyle(color: Colors.white))
                    ]),
              ),
            ),
            Image.asset("assets/images/logoWithoutBackground.png")
          ]),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/defaultProfilePic.jpg'),
            ),
          ),
        ]);
  }
}
