import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_assistant/data/models/assistant/assistant_model.dart';
import 'package:game_assistant/data/models/thread/index.dart';
import 'package:game_assistant/presentation/chat/blocs/chat_bloc/chat_bloc.dart';
import 'package:game_assistant/presentation/chat/screen/chat_screen.dart';
import 'package:game_assistant/presentation/game_screen/screen/game_screen.dart';
import 'package:game_assistant/presentation/home/screen/index.dart';
import 'package:game_assistant/presentation/navigation/screen/navigation_screen.dart';

class AppRoute {
  static const String navigationScreen = '/navigation_screen';
  static const String homeScreen = '/home_screen';
  static const String chatScreen = '/chat_screen';
  static const String gameScreen = '/game_screen';
  static const String splashScreen = '/splash_screen';

  static Widget screenToShow(RouteSettings setting) {
    switch (setting.name) {
      case homeScreen:
        return const HomeScreen();
      case navigationScreen:
        return const NavigationScreen();
      case chatScreen:
        final data = setting.arguments as Map<String, dynamic>?;
        final assistant = data?['assistant'] as AssistantModel?;
        final thread = data?['thread'] as ThreadModel?;
        // AssistantModel?;
        return BlocProvider(
          create: (context) => data?['thread'] == null
              ? (ChatBloc()
                ..add(
                  CreateThread(
                    assistant: assistant,
                  ),
                ))
              : (ChatBloc()..add(FetchMessages(thread: thread))),
          child: ChatScreen(
            assistant: assistant,
            thread: thread,
          ),
        );
      case gameScreen:
        return const GameScreen();
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Unknow Screen'),
          ),
          body: const Center(
            child: Text("Route isn't exits"),
          ),
        );
    }
  }

  static Route<dynamic> generateRoute(RouteSettings setting) {
    return MaterialPageRoute(
      settings: setting,
      builder: (context) {
        return screenToShow(setting);

        /// Config same
        // ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // if (EasyLoading.isShow) {
        //   EasyLoading.dismiss();
        // }
        // WillPopScope(
        //     onWillPop: () async {
        //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //       if (EasyLoading.isShow) {
        //         EasyLoading.dismiss();
        //         return false;
        //       } else {
        //         return true;
        //       }
        //     },
        //     child:
      },
    );
  }
}
