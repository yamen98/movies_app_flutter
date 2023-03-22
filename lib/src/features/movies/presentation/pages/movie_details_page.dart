import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/presentation/pages/background_page.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      backgroundColor: AppColors.primaryColor,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://m.media-amazon.com/images/M/MV5BYmY3NzhkNzctZDgzYi00MjkzLWEzNWUtNWNlYTA3YjYxOWYzXkEyXkFqcGdeQXVyMjQxNTYxNTk@._V1_SX300.jpg",
            height: ScreenUtil().screenHeight * 0.5,
            width: ScreenUtil().screenWidth,
            fit: BoxFit.cover,
          ),

          // Shadow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.6, 0.95],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
