import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/cached_image_widget.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';
import 'package:movies_app/src/core/util/constant/app_constants.dart';
import 'package:shimmer/shimmer.dart';

class MovieCardShimmerWidget extends StatefulWidget {
  const MovieCardShimmerWidget({
    super.key,
  });

  @override
  State<MovieCardShimmerWidget> createState() => _MovieCardShimmerWidgetState();
}

class _MovieCardShimmerWidgetState extends State<MovieCardShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
                child: ColoredBox(
              color: AppColors.gray,
            )),
          )),
    );
  }
}
