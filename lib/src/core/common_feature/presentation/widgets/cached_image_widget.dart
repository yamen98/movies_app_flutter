import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/core/util/helper.dart';

class CachedImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imageUrl;
  final double? radius;
  final GlobalKey _backgroundImageKey = GlobalKey();

  CachedImageWidget({
    Key? key,
    this.width,
    this.height,
    required this.imageUrl,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: radius == null
            ? null
            : BoxDecoration(
                // image: DecorationImage(image: NetworkImage(appAdvert.imageUrl)),
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
        height: height,
        width: width,
        child: imageUrl != null && imageUrl != ""
            ? CachedNetworkImage(
                key: _backgroundImageKey,
                imageUrl: imageUrl ?? "",
                height: height,
                width: width,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  Helper.getImagePath("no_image.jpg"),
                  fit: BoxFit.fill,
                ),
              )
            : Image.asset(
                'assets/images/no_records.png',
                height: height,
                width: width,
                fit: BoxFit.contain,
              ));
  }
}
