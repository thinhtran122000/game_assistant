import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/themes/colors/colors.dart';
import 'package:game_assistant/themes/styles/text_style.dart';
import 'package:game_assistant/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkItem extends StatelessWidget {
  final List<Resource> resources;
  final String? avatar;
  const LinkItem({
    super.key,
    this.resources = const [],
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return resources.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 50,
            child: ListView.separated(
              separatorBuilder: (context, resourceIndex) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: resources.length,
              itemBuilder: itemBuilder,
            ),
          );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async => await launchUrl(Uri.parse(resources[index].resourceUrl ?? '')),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    width: 18,
                    height: 18,
                    imageUrl: AppUtils.proxyImageUrl(resources[index].siteIconUrl ?? ''),
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: Stack(
                        children: [
                          CircularProgressIndicator(
                            value: progress.progress,
                            color: Colors.green,
                            strokeWidth: 1,
                          ),
                          if (progress.progress != null)
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${((progress.progress ?? 0) / 1 * 100).ceil()} %',
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    errorWidget: (context, url, error) => CachedNetworkImage(
                      imageUrl: avatar ?? '',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  resources[index].resourceName ?? '',
                  style: mediumStyle.copyWith(
                    color: Colors.black,
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
