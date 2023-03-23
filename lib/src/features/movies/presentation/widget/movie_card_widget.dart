import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/app_flow_delegate.dart';
import 'package:movies_app/src/core/common_feature/presentation/widgets/cached_image_widget.dart';
import 'package:movies_app/src/core/util/constant/app_constants.dart';
import 'package:movies_app/src/features/movies/domain/entities/movies_model.dart';

class MovieCardWidget extends StatefulWidget {
  final MoviesModel model;
  final Function() onTap;

  const MovieCardWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Keep direction to ltr because data is english
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 300.h,
        child: GestureDetector(
          onTap: widget.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradientShadow(),
                _buildTitleAndDate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Movie image
  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        CachedImageWidget(
          imageUrl: widget.model.poster,
          key: _backgroundImageKey,
          // fit: BoxFit.cover,
        ),
      ],
    );
  }

  // Black shadow
  Widget _buildGradientShadow() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  // Movie title and date
  Widget _buildTitleAndDate() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.model.title ?? defaultStr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${widget.model.type}/${widget.model.year}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
