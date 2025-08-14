import 'package:cached_network_image/cached_network_image.dart';
import 'package:game_assistant/assets/index.dart';
import 'package:game_assistant/data/models/message/index.dart';
import 'package:game_assistant/presentation/chat/blocs/chat_bloc/chat_bloc.dart';
import 'package:game_assistant/themes/colors/colors.dart';
import 'package:game_assistant/themes/styles/text_style.dart';
import 'package:game_assistant/widgets/item/tertiary/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class TertiaryItem extends StatelessWidget {
  final String avatar;
  final String? label;
  final ChatBloc bloc;
  final MessageModel message;
  // final int index;
  const TertiaryItem({
    super.key,
    required this.avatar,
    this.label,
    required this.bloc,
    required this.message,
    // required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: () => context.read<ChatBloc>().add(DeleteMessage(
      //       thread: bloc.state.thread,
      //       messageId: bloc.state.listMessage[index].id ?? '',
      //     )),
      child: Align(
        alignment: message.role == 'assistant' ? Alignment.centerLeft : Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.role == 'assistant')
              Row(
                children: [
                  Flexible(
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green.withOpacity(0.7),
                      backgroundImage: CachedNetworkImageProvider(avatar),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    flex: 2,
                    child: Text(
                      label ?? '',
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(maxWidth: 350), // Set max width
              decoration: BoxDecoration(
                color: message.role == 'assistant' ? lightGreyColor : blueColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    blurStyle: BlurStyle.solid,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),

              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (message.content[0].text?.value == null) {
                    if (state is ChatSearching) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Searching web',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          LottieBuilder.asset(
                            LottiesPath.loadingMessage,
                            alignment: Alignment.bottomCenter,
                            width: 30,
                            height: 20,
                          ),
                        ],
                      );
                    } else if (state is ChatLoading) {
                      return LottieBuilder.asset(
                        LottiesPath.loadingMessage,
                        width: 30,
                        height: 20,
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    final value = message.content[0].text?.value;
                    if (value is String?) {
                      return Text(
                        value ?? '',
                        // style: TextStyle(
                        //   fontSize: 15,
                        //   ,
                        // ),
                        style: mediumStyle.copyWith(
                          color: message.role == 'assistant' ? Colors.black : Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      );
                    } else if (value is Value?) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            child: ContentItem(
                              content: value?.text?.value ?? '',
                            ),
                          ),
                          Flexible(
                            child: ImageItem(
                              imageUrls: value?.images?.imageUrl ?? [],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: VideoItem(
                              videos: value?.videos?.videoUrl ?? [],
                            ),
                          ),
                          Flexible(
                            child: LinkItem(
                              avatar: avatar,
                              resources: value?.resources?.resourceList ?? [],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
