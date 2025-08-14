import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_assistant/utils/app_utils.dart';

class ImageItem extends StatelessWidget {
  final List<String> imageUrls;
  const ImageItem({
    super.key,
    this.imageUrls = const [],
  });

  @override
  Widget build(BuildContext context) {
    return imageUrls.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, imageindex) => const SizedBox(width: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: imageUrls.length,
              itemBuilder: itemBuilder,
            ),
          );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: AppUtils.proxyImageUrl(imageUrls[index]),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        progressIndicatorBuilder: (context, url, progress) => const SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => const SizedBox(),
      ),
    );
  }
}
