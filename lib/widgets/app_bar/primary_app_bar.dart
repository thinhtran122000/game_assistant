import 'package:game_assistant/themes/colors/colors.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapLeading;
  final Widget? title;
  final List<Widget> actions;
  final bool? centerTitle;
  final bool? enabledLeading;
  final bool? enabledActions;

  const PrimaryAppBar({
    super.key,
    this.onTapLeading,
    this.title,
    this.actions = const [],
    this.centerTitle,
    this.enabledLeading,
    this.enabledActions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: blueColor,
      titleSpacing: 0,
      leadingWidth: 50,
      centerTitle: centerTitle,
      actions: enabledActions ?? false ? actions : null,
      title: title,
      leading: enabledLeading ?? false
          ? GestureDetector(
              onTap: onTapLeading,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
