import 'package:flutter/material.dart';

class SecondaryTitleAppBar extends StatelessWidget {
  final String? titleName;
  const SecondaryTitleAppBar({
    super.key,
    this.titleName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleName ?? '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
