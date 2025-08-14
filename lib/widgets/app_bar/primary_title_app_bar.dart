import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PrimaryTitleAppBar extends StatelessWidget {
  final String imageUrl;
  final String? titleName;
  const PrimaryTitleAppBar({
    super.key,
    required this.imageUrl,
    this.titleName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.green.withOpacity(0.7),
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 2,
          child: Text(
            titleName ?? '',
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
