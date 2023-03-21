import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/cached_image_widget.dart';
import 'package:movies_app/src/core/styles/app_colors.dart';
import 'package:movies_app/src/core/util/constant/app_constants.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';

class MovieCardWidget extends StatefulWidget {
  final MoviesModel model;

  const MovieCardWidget({super.key, required this.model});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Movie Image
          CachedImageWidget(
            imageUrl: widget.model.poster,
            radius: 12,
            width: ScreenUtil().screenWidth,
          ),

          // Shadow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.transparent,
                      AppColors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.95]),
              ),
            ),
          ),

          // Name And Other Information
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.title ?? defaultStr,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                Text(
                  "${widget.model.type}/${widget.model.year}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
