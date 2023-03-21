import 'package:movies_app/src/core/util/helper.dart';
import 'package:movies_app/src/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late IntroBloc bloc;

  @override
  void initState() {
    bloc = IntroBloc();
    bloc.add(OnGettingDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Image.asset(
            Helper.getImagePath("logo.jpg"),
            width: 100.w,
            height: 100.h,
          ),
        ),
      ),
    );
  }
}
