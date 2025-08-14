import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PrimaryItem extends StatelessWidget {
  final VoidCallback? onTapItem;
  final VoidCallback? onTapDeleteItem;

  final String imageUrl;
  final String? label;
  const PrimaryItem({
    super.key,
    this.onTapItem,
    this.onTapDeleteItem,
    required this.imageUrl,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              blurStyle: BlurStyle.solid,
              color: Colors.grey,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.7),
                    backgroundImage: CachedNetworkImageProvider(imageUrl),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      label ?? '',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Flexible(
              child: GestureDetector(
                onTap: onTapDeleteItem,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
