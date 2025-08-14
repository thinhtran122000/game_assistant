import 'package:game_assistant/core/routes/app_route.dart';
import 'package:game_assistant/data/models/message/index.dart';
import 'package:game_assistant/presentation/conversation/blocs/conversation_bloc/conversation_bloc.dart';
import 'package:game_assistant/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:game_assistant/widgets/app_bar/index.dart';
import 'package:game_assistant/widgets/item/primary/primary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationScreen extends StatelessWidget {
  final String? name;
  const ConversationScreen({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        centerTitle: true,
        enabledLeading: false,
        enabledActions: true,
        title: const SecondaryTitleAppBar(
          titleName: 'Conversations',
        ),
        actions: [
          GestureDetector(
            onTap: () => BlocProvider.of<ConversationBloc>(context).add(DeleteAllThread()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is NavigationInitial && state.index == 1) {
            context.read<ConversationBloc>().add(FetchThreads());
          }
        },
        child: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            if (state is ConversationError) {
              return Text(
                state.errorMessage,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: itemBuilder,
              separatorBuilder: separatorBuilder,
              itemCount: state.listThread.length,
            );
          },
        ),
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final bloc = context.read<ConversationBloc>();
    return PrimaryItem(
      imageUrl: bloc.state.listThread[index].metadata?['image_url'] ?? '',
      label: bloc.state.listThread[index].id,
      onTapDeleteItem: () => bloc.add(DeleteThread(
        thread: bloc.state.listThread[index],
      )),
      onTapItem: () async {
        await Navigator.of(context).pushNamed(
          AppRoute.chatScreen,
          arguments: {
            'thread': bloc.state.listThread[index],
          },
        ).then((messages) {
          if (messages is List<MessageModel>? && messages != null && messages.isEmpty) {
            bloc.add(DeleteThread(
              thread: bloc.state.listThread[index],
            ));
          } else {
            return;
          }
        });
      },
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 10);
}
