import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/colors.dart';
import '../../injection/injector.dart';

class ImageBuilder extends StatelessWidget {
  final String imageUrl;
  final ImageProvider? imageProvider;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final bool circular;

  const ImageBuilder({
    super.key,
    this.imageUrl = "",
    this.imageProvider,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.circular = false,
  });

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (imageUrl.isNotEmpty) {
      child = CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(color: themeBloc.tColor()),
              borderRadius: borderRadius,
              shape: circular ? BoxShape.circle : BoxShape.rectangle,
            ),
            child: const Icon(Icons.error, color: kError, size: 12),
          );
        },
      );
    } else if (imageProvider != null) {
      child = Image(
        width: width,
        height: height,
        image: imageProvider!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          print(error);
          return const Center(child: CupertinoActivityIndicator());
        },
      );
    } else {
      child = SizedBox(
        width: width,
        height: height,
        child: const Center(child: CupertinoActivityIndicator()),
      );
    }

    if (circular) {
      child = ClipOval(child: child);
    } else if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}
