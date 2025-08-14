import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/core/routes/app_route.dart';
import 'package:game_assistant/presentation/home/blocs/home_bloc/home_bloc.dart';
import 'package:game_assistant/themes/colors/colors.dart';
import 'package:game_assistant/widgets/app_bar/index.dart';
import 'package:game_assistant/widgets/item/primary/primary_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>()..add(FetchAssistants()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PrimaryAppBar(
          centerTitle: true,
          enabledLeading: false,
          title: SecondaryTitleAppBar(titleName: 'Game Assistant'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return Text(state.errorMessage);
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              itemCount: state.listAssistant.length,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: blueColor,
          onPressed: () async => Navigator.of(context).pushNamed(AppRoute.gameScreen),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final bloc = getIt<HomeBloc>();
    return PrimaryItem(
      imageUrl: bloc.state.listAssistant[index].metadata?['image_url'] ?? '',
      label: bloc.state.listAssistant[index].name,
      onTapItem:
          () => Navigator.of(
            context,
          ).pushNamed(AppRoute.chatScreen, arguments: {'assistant': bloc.state.listAssistant[index], 'thread': null}),
      onTapDeleteItem: () => bloc.add(DeleteAssistant(assistantId: bloc.state.listAssistant[index].id ?? '')),
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 10);
}
