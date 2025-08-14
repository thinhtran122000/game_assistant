import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/presentation/chat/blocs/chat_bloc/chat_bloc.dart';
import 'package:game_assistant/widgets/app_bar/index.dart';
import 'package:game_assistant/widgets/item/index.dart';
import 'package:game_assistant/widgets/text_field/primary_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final AssistantModel? assistant;
  final ThreadModel? thread;
  const ChatScreen({
    super.key,
    this.assistant,
    this.thread,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController textController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PrimaryAppBar(
        enabledLeading: true,
        title: PrimaryTitleAppBar(
          
          imageUrl: (assistant?.metadata?['image_url'] ?? thread?.metadata?['image_url']) ?? '',
          titleName: (assistant?.name ?? thread?.metadata?['name']) ?? '',
        ),
        onTapLeading: () => Navigator.of(context).pop(
          BlocProvider.of<ChatBloc>(context).state.listMessage,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatError) {
                  return Text(state.errorMessage.toString());
                }
                if (state is ChatThreadLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      radius: 10,
                    ),
                  );
                }
                return ListView.separated(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  itemCount: state.listMessage.length,
                  separatorBuilder: separatorBuilder,
                  itemBuilder: itemBuilder,
                  controller: scrollController,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 8, bottom: 25),
              decoration: const BoxDecoration(
                  // color: Colors.green,
                  ),
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 3,
                        child: PrimaryTextField(
                          controller: textController,
                          onSendMessage: () {
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                            );
                            context.read<ChatBloc>().add(
                                  CreateMessage(
                                    thread: state.thread,
                                    message: textController.text,
                                    onCallback: (thread) => context.read<ChatBloc>().add(
                                          CreateRun(
                                            thread: thread,
                                            assistant: assistant,
                                          ),
                                        ),
                                  ),
                                );
                            textController.clear();
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.read<ChatBloc>().add(FetchMessages(thread: state.thread)),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 25,
                          grade: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? itemBuilder(BuildContext context, int index) {
    final bloc = context.read<ChatBloc>();
    final message = bloc.state.listMessage[index];
    return TertiaryItem(
      avatar: (assistant?.metadata?['image_url'] ?? thread?.metadata?['image_url']) ?? '',
      bloc: bloc,
      message: message,
      label: assistant?.name ?? thread?.metadata?['name'],
    );
  }

  Widget separatorBuilder(BuildContext context, int index) => const SizedBox(height: 10);
}



 // return GestureDetector(
    //   // onLongPress: () => context.read<ChatBloc>().add(DeleteMessage(
    //   //       thread: bloc.state.thread,
    //   //       messageId: bloc.state.listMessage[index].id ?? '',
    //   //     )),
    //   child: Align(
    //     alignment: message.role == 'assistant' ? Alignment.centerLeft : Alignment.centerRight,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         if (message.role == 'assistant')
    //           Row(
    //             children: [
    //               Flexible(
    //                 child: CircleAvatar(
    //                   radius: 10,
    //                   backgroundColor: Colors.green.withOpacity(0.7),
    //                   backgroundImage: Image.network(
    //                     (assistant?.metadata?['image_url'] ?? thread?.metadata?['image_url']) ?? '',
    //                   ).image,
    //                 ),
    //               ),
    //               const SizedBox(width: 5),
    //               Flexible(
    //                 flex: 2,
    //                 child: Text(
    //                   (assistant?.name ?? thread?.metadata?['name']) ?? '',
    //                   softWrap: true,
    //                   style: const TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         const SizedBox(height: 10),
    //         Container(
    //           padding: const EdgeInsets.all(10),
    //           constraints: const BoxConstraints(maxWidth: 250), // Set max width
    //           decoration: BoxDecoration(
    //             color: message.role == 'assistant' ? Colors.grey[200] : Colors.green,
    //             borderRadius: BorderRadius.circular(20),
    //             boxShadow: [
    //               BoxShadow(
    //                 blurRadius: 3,
    //                 blurStyle: BlurStyle.solid,
    //                 color: Colors.grey.withOpacity(0.5),
    //               ),
    //             ],
    //           ),

    //           child: BlocBuilder<ChatBloc, ChatState>(
    //             builder: (context, state) {
    //               if (bloc.state.listMessage[index].content[0].text?.value == null) {
    //                 if (state is ChatSearching) {
    //                   return Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       const Text(
    //                         'Searching web',
    //                         style: TextStyle(
    //                           fontSize: 15,
    //                           fontWeight: FontWeight.w400,
    //                           color: Colors.black,
    //                         ),
    //                       ),
    //                       LottieBuilder.asset(
    //                         LottiesPath.loadingMessage,
    //                         alignment: Alignment.bottomCenter,
    //                         width: 30,
    //                         height: 20,
    //                       ),
    //                     ],
    //                   );
    //                 } else if (state is ChatLoading) {
    //                   return LottieBuilder.asset(
    //                     LottiesPath.loadingMessage,
    //                     width: 30,
    //                     height: 20,
    //                   );
    //                 } else {
    //                   return const SizedBox();
    //                 }
    //               } else {
    //                 final value = bloc.state.listMessage[index].content[0].text?.value;
    //                 if (value is String?) {
    //                   return Text(
    //                     value ?? '',
    //                     style: TextStyle(
    //                       fontSize: 15,
    //                       color: message.role == 'assistant' ? Colors.black : Colors.white,
    //                     ),
    //                     softWrap: true,
    //                     overflow: TextOverflow.clip,
    //                   );
    //                 } else if (value is Value?) {
    //                   return Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Flexible(
    //                         flex: 5,
    //                         child: SelectableText.rich(
    //                           TextSpan(
    //                             children: buildExtractMessage(
    //                               AppUtils.removeSpecificSymbols(
    //                                 value?.text?.value ?? '',
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       (value?.images?.imageUrl ?? []).isEmpty
    //                           ? const SizedBox()
    //                           : Flexible(
    //                               child: SizedBox(
    //                                 // width: 50,
    //                                 height: 110,
    //                                 child: ListView.separated(
    //                                   scrollDirection: Axis.horizontal,
    //                                   separatorBuilder: (context, imageindex) => const SizedBox(width: 10),
    //                                   padding: const EdgeInsets.symmetric(vertical: 10),
    //                                   itemCount: (value?.images?.imageUrl ?? []).length,
    //                                   itemBuilder: (context, imageindex) {
    //                                     return Container(
    //                                       clipBehavior: Clip.hardEdge,
    //                                       // borderRadius: BorderRadius.circular(10),
    //                                       decoration: BoxDecoration(
    //                                           borderRadius: BorderRadius.circular(10),
    //                                           color: Colors.white,
    //                                           // border: Border.all(
    //                                           //   color: Colors.grey,
    //                                           // ),
    //                                           boxShadow: [
    //                                             BoxShadow(
    //                                               blurRadius: 3,
    //                                               color: Colors.grey.withOpacity(0.5),
    //                                             ),
    //                                           ]),
    //                                       child: CachedNetworkImage(
    //                                         imageUrl: AppUtils.proxyImageUrl((value?.images?.imageUrl ?? [])[imageindex]),
    //                                         fit: BoxFit.cover,
    //                                         filterQuality: FilterQuality.high,
    //                                         progressIndicatorBuilder: (context, url, progress) => const SizedBox(
    //                                           width: 100,
    //                                           height: 100,
    //                                           child: Center(
    //                                             child: CupertinoActivityIndicator(),
    //                                           ),
    //                                         ),
    //                                         errorWidget: (context, url, error) => const SizedBox(),
    //                                       ),
    //                                     );
    //                                   },
    //                                 ),
    //                               ),
    //                             ),
    //                       (value?.videos?.videoUrl ?? []).isEmpty
    //                           ? const SizedBox()
    //                           : Flexible(
    //                               flex: 2,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(vertical: 5),
    //                                 child: ClipRRect(
    //                                   borderRadius: BorderRadius.circular(10),
    //                                   child: YoutubePlayer(
    //                                     aspectRatio: 5 / 4,
    //                                     controller: YoutubePlayerController.fromVideoId(
    //                                       videoId: YoutubePlayerController.convertUrlToId(value?.videos?.videoUrl[0] ?? '') ?? '',
    //                                       autoPlay: false,
    //                                       params: const YoutubePlayerParams(),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                       (value?.resources?.resourceList ?? []).isEmpty
    //                           ? const SizedBox()
    //                           : Flexible(
    //                               flex: 1,
    //                               child: ConstrainedBox(
    //                                 constraints: const BoxConstraints(maxHeight: 50),
    //                                 // width: 50,
    //                                 child: ListView.separated(
    //                                   separatorBuilder: (context, resourceIndex) => const SizedBox(width: 10),
    //                                   scrollDirection: Axis.horizontal,
    //                                   itemCount: (value?.resources?.resourceList ?? []).length,
    //                                   itemBuilder: (context, resourceIndex) {
    //                                     final listResource = value?.resources?.resourceList;
    //                                     return FutureBuilder<bool>(
    //                                       future: AppUtils.checkValidUrl(listResource?[resourceIndex].resourceUrl ?? ''),
    //                                       builder: (context, snapshot) {
    //                                         return GestureDetector(
    //                                           onTap: () async => await launchUrl(Uri.parse(listResource?[resourceIndex].resourceUrl ?? '')),
    //                                           child: Row(
    //                                             children: [
    //                                               Container(
    //                                                 decoration: BoxDecoration(
    //                                                   color: Colors.white,
    //                                                   borderRadius: BorderRadius.circular(20),
    //                                                 ),
    //                                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                                                 child: Row(
    //                                                   children: [
    //                                                     ClipRRect(
    //                                                       borderRadius: BorderRadius.circular(30),
    //                                                       child: CachedNetworkImage(
    //                                                         width: 18,
    //                                                         height: 18,
    //                                                         imageUrl: AppUtils.proxyImageUrl(listResource?[resourceIndex].siteIconUrl ?? ''),
    //                                                         progressIndicatorBuilder: (context, url, progress) => Center(
    //                                                           child: Stack(
    //                                                             children: [
    //                                                               CircularProgressIndicator(
    //                                                                 value: progress.progress,
    //                                                                 color: Colors.green,
    //                                                                 strokeWidth: 1,
    //                                                               ),
    //                                                               if (progress.progress != null)
    //                                                                 Positioned(
    //                                                                   top: 0,
    //                                                                   bottom: 0,
    //                                                                   left: 0,
    //                                                                   right: 0,
    //                                                                   child: Align(
    //                                                                     alignment: Alignment.center,
    //                                                                     child: Text(
    //                                                                       '${((progress.progress ?? 0) / 1 * 100).ceil()} %',
    //                                                                     ),
    //                                                                   ),
    //                                                                 )
    //                                                             ],
    //                                                           ),
    //                                                         ),
    //                                                         errorWidget: (context, url, error) => CachedNetworkImage(
    //                                                           imageUrl: (thread?.metadata?['image_url'] ?? assistant?.metadata?['image_url']) ?? '',
    //                                                         ),
    //                                                       ),
    //                                                     ),
    //                                                     const SizedBox(width: 10),
    //                                                     Text(
    //                                                       value?.resources?.resourceList[resourceIndex].resourceName ?? '',
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //                                         );
    //                                       },
    //                                     );
    //                                   },
    //                                 ),
    //                               ),
    //                             ),
    //                     ],
    //                   );
    //                 } else {
    //                   return const SizedBox();
    //                 }
    //               }
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

// index == bloc.state.listMessage.length
// ? const CupertinoActivityIndicator(
//     radius: 10,
//   )
//     :
// StreamBuilder<String>(
//         stream: bloc.state.streamController?.stream,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text(
//               'Error: ${snapshot.error}',
//               style: const TextStyle(fontSize: 16),
//             );
//           } else if (snapshot.hasData) {
//             return Text(
//               snapshot.data ?? '',
//               style: const TextStyle(fontSize: 16),
//               maxLines: null, // Allow unlimited lines
//               overflow: TextOverflow.visible,
//             );
//           } else {
//             return Text(
//               bloc.state.listMessage[index].content[0].text?.value ?? '',
//               style: const TextStyle(fontSize: 16),
//               maxLines: null, // Allow unlimited lines
//               overflow: TextOverflow.visible,
//             );
//           }
//         }),
