import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_assistant/core/index.dart';
import 'package:game_assistant/core/routes/app_route.dart';
import 'package:game_assistant/data/local_store/config/config_local_store.dart';
import 'package:game_assistant/data/local_store/controllers/thread_controller.dart';
import 'package:game_assistant/obsever/app_bloc_obsever.dart';
import 'package:game_assistant/presentation/conversation/blocs/conversation_bloc/conversation_bloc.dart';
import 'package:game_assistant/presentation/home/blocs/home_bloc/home_bloc.dart';

void main() async {
  /// init Splash Screen
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  configureInjectableApp();
  await configLocalStore();
  await ThreadController.open();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        // BlocProvider(
        //   create: (context) => ChatBloc(),
        // ),
        BlocProvider(create: (context) => ConversationBloc()..add(FetchThreads())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assistant Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        onGenerateRoute: AppRoute.generateRoute,
        initialRoute: AppRoute.navigationScreen,
      ),
    );
  }
}
