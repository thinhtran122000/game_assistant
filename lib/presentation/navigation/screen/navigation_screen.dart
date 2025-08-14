import 'package:game_assistant/assets/icons_path.dart';
import 'package:game_assistant/core/routes/app_route.dart';
import 'package:game_assistant/presentation/conversation/screen/conversation_screen.dart';
import 'package:game_assistant/presentation/home/screen/home_screen.dart';
import 'package:game_assistant/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:game_assistant/themes/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return PopScope(
            onPopInvoked: (didPop) {
              if (ModalRoute.of(context)?.settings.name == AppRoute.navigationScreen) {
                SystemNavigator.pop();
              }
            },
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) =>
                    value != state.index ? context.read<NavigationBloc>().add(NavigateToScreen(index: value)) : null,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                // selectedItemColor: blueColor,
                unselectedItemColor: Colors.grey.withOpacity(0.3),
                type: BottomNavigationBarType.fixed,
                currentIndex: state.index,
                items: state.screens
                    .map<BottomNavigationBarItem>(
                      (e) => BottomNavigationBarItem(
                        label: e,
                        icon: SvgPicture.asset(
                          getIconPath(state.screens.indexOf(e)),
                          colorFilter: ColorFilter.mode(
                            state.screens.indexOf(e) == state.index ? blueColor : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              body: IndexedStack(
                index: state.index,
                children: const [
                  HomeScreen(),
                  ConversationScreen(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getIconPath(int index) {
    switch (index) {
      case 0:
        return IconsPath.homeIcon;
      case 1:
        return IconsPath.chatIcon;
      case 2:
        return IconsPath.chatIcon;
      default:
        return IconsPath.homeIcon;
    }
  }
}
