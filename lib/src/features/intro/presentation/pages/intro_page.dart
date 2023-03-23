import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/src/core/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(
        seconds: 1,
      ),
      () {
        Navigator.pushNamed(context, "/movies_page");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: SvgPicture.asset(
            Helper.getSvgPath("logo.svg"),
            width: 100.w,
            height: 100.h,
          ),
        ),
      ),
    );
  }
}
