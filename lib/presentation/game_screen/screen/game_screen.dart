import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_assistant/constants/constants.dart';
import 'package:game_assistant/core/di/di.dart';
import 'package:game_assistant/presentation/home/blocs/home_bloc/home_bloc.dart';
import 'package:game_assistant/widgets/app_bar/index.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        centerTitle: true,
        enabledLeading: true,
        onTapLeading: () => Navigator.of(context).pop(),
        title: SecondaryTitleAppBar(titleName: 'Game Gallery'),
      ),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: itemBuilder,
          itemCount: listGame.length,
        ),
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        getIt<HomeBloc>().add(CreateAssistant(gameName:  listGame[index].gameName ?? '', imageGame:  listGame[index].imageGame ?? ''));
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 3, blurStyle: BlurStyle.solid, color: Colors.grey)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(listGame[index].imageGame ?? '')),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  listGame[index].gameName ?? '',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
