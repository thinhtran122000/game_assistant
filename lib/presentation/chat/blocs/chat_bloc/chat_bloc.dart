import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:game_assistant/constants/constants.dart';
import 'package:game_assistant/core/index.dart';
import 'package:game_assistant/data/local_store/controllers/thread_controller.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/presentation/conversation/blocs/conversation_bloc/conversation_bloc.dart';
import 'package:game_assistant/repository/google_repository.dart';
import 'package:game_assistant/repository/message_repository.dart';
import 'package:game_assistant/repository/run_repository.dart';
import 'package:game_assistant/repository/submit_tool_repository.dart';
import 'package:game_assistant/repository/thread_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

// @lazySingleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessageRepository messageRepository = MessageRepository();
  final ThreadRepository threadRepository = ThreadRepository();
  final RunRepository runRepository = RunRepository();
  final SubmitToolRepository submitToolRepository = SubmitToolRepository();
  final GoogleRepository googleRepository = GoogleRepository();

  ChatBloc()
      : super(ChatInitial(
          listMessage: [],
          thread: ThreadModel(),
          streamController: null,
        )) {
    on<CreateThread>(_onCreateThread);
    on<FetchMessages>(_onFetchMessages);
    on<CreateMessage>(_onCreateMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<CreateRun>(_onCreateRun);
  }

  FutureOr<void> _onCreateThread(CreateThread event, Emitter<ChatState> emit) async {
    try {
      emit(ChatThreadLoading(listMessage: state.listMessage, thread: state.thread));
      final thread = await threadRepository.createThread(
        role: 'assistant',
        metadata: {
          'assistant_id': event.assistant?.id ?? '',
          'name': event.assistant?.name ?? '',
          //  'preferred_language': 'es',
          'image_url': event.assistant?.metadata?['image_url'] ?? '',
        },
        content: [
          {
            'type': 'text',
            'text': '''I'm ${event.assistant?.name}. How can i help you today ?''',
          }
        ],
      );
      add(FetchMessages(thread: thread));
    } catch (e) {
      emit(
        ChatError(
          errorMessage: e.toString(),
          listMessage: state.listMessage,
          thread: state.thread,
        ),
      );
    }
  }

  FutureOr<void> _onFetchMessages(FetchMessages event, Emitter<ChatState> emit) async {
    try {
      final listMessage = await messageRepository.getMessages(
        threadId: event.thread?.id ?? '',
        order: 'desc',
      );
      emit(ChatInitial(
        listMessage: listMessage,
        thread: event.thread ?? ThreadModel(),
      ));
    } catch (e) {
      emit(
        ChatError(
          errorMessage: e.toString(),
          listMessage: state.listMessage,
          thread: state.thread,
        ),
      );
    }
  }

  FutureOr<void> _onCreateMessage(CreateMessage event, Emitter<ChatState> emit) async {
    try {
      if (event.message.isEmpty) {
        return;
      } else {
        emit(ChatInitial(
          listMessage: [
            MessageModel(
              threadId: event.thread.id ?? '',
              role: 'user',
              content: [
                Content(
                  type: 'text',
                  text: TextModel(
                    value: event.message,
                  ),
                ),
              ],
            ),
            ...state.listMessage,
          ],
          thread: state.thread,
        ));
        await messageRepository.createMessage(
          threadId: event.thread.id ?? '',
          role: 'user',
          type: 'text',
          text: event.message,
        );
        event.onCallback.call(event.thread);
        if (state.listMessage.length > 1) {
          ThreadController.createThread(event.thread);
        }
      }
    } catch (e) {
      emit(
        ChatError(
          errorMessage: e.toString(),
          listMessage: state.listMessage,
          thread: state.thread,
        ),
      );
    }
  }

  FutureOr<void> _onDeleteMessage(DeleteMessage event, Emitter<ChatState> emit) async {
    try {
      await messageRepository.deleteMessage(
        threadId: event.thread.id ?? '',
        messageId: event.messageId,
      );
      add(FetchMessages(thread: event.thread));
      if (state.listMessage.isEmpty) {
        getIt<ConversationBloc>().add(DeleteThread(thread: event.thread));
      }
    } catch (e) {
      emit(
        ChatError(
          errorMessage: e.toString(),
          listMessage: state.listMessage,
          thread: state.thread,
        ),
      );
    }
  }

  FutureOr<void> _onCreateRun(CreateRun event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading(
        listMessage: [
          MessageModel(
            threadId: event.thread?.id ?? '',
            role: 'assistant',
            content: [
              Content(
                type: 'text',
                text: TextModel(
                  value: null,
                ),
              ),
            ],
          ),
          ...state.listMessage,
        ],
        thread: state.thread,
      ));
      final result = await runRepository.createRun(
        threadId: event.thread?.id ?? '',
        assistantId: event.assistant?.id ?? event.thread?.metadata?['assistant_id'] ?? '',
      );

      while (true) {
        await Future.delayed(const Duration(milliseconds: 50));
        final runDetails = await runRepository.getRunDetails(
          threadId: event.thread?.id ?? '',
          runId: result.id ?? '',
        );
        if (runDetails.status == 'requires_action') {
          emit(ChatSearching(
            listMessage: state.listMessage,
            thread: state.thread,
          ));
          final searchResult = await Future.wait(
              (runDetails.requiredAction?.submitToolOutputs?.toolCalls ?? []).map<Future<Map<String, dynamic>>>(
            (e) async {
              switch (e.function?.name ?? '') {
                case 'web_search_and_summarize':
                  {
                    final customResult = await googleRepository.getSearch(
                      apiKey: Constants.googleApiKey,
                      engineId: Constants.engineId,
                      query: jsonDecode(e.function?.arguments ?? '')['query'],
                      sort: Constants.sortOrder,
                    );
                    final encode = jsonEncode(customResult);
                    return {
                      'tool_call_id': e.id,
                      'output': encode,
                    };
                  }
                case 'web_search_youtube_resource':
                  {
                    final youtubeResult = await googleRepository.getSearch(
                      apiKey: Constants.googleApiKey,
                      engineId: Constants.engineId,
                      query: jsonDecode(e.function?.arguments ?? '')['query'],
                      sort: Constants.sortOrder,
                      siteSearch: 'https://www.youtube.com',
                      siteSearchFilter: 'i',
                    );

                    final encode = jsonEncode(youtubeResult);
                    return {
                      'tool_call_id': e.id,
                      'output': encode,
                    };
                  }
                default:
                  return {};
              }
            },
          ).toList());
          do {
            log('submit tool again');
            await submitToolRepository
                .submitTool(
              threadId: event.thread?.id ?? '',
              runId: result.id ?? '',
              toolOutputs: searchResult,
            )
                .then(
              (value) async {
                emit(ChatLoading(
                  listMessage: state.listMessage,
                  thread: state.thread,
                ));
              },
            );
          } while (runDetails.status != 'requires_action');
          continue;
        } else if (runDetails.status == 'completed') {
          add(FetchMessages(thread: event.thread));
          break;
        } else if (runDetails.status == 'expired' ||
            runDetails.status == 'failed' ||
            runDetails.status == 'incomplete' ||
            runDetails.status == 'cancelled') {
          break;
        } else {
          continue;
        }
      }
    } catch (e) {
      emit(
        ChatError(
          errorMessage: e.toString(),
          listMessage: state.listMessage,
          thread: state.thread,
          streamController: state.streamController?..close(),
        ),
      );
    }
  }
}

 // emit(ChatLoading(listMessage: state.listMessage, thread: state.thread));
      // runRepository
      //         .createRun(
      //   threadId: event.thread?.id ?? '',
      //   assistantId: event.assistant?.id ?? '',
      // )
      //         .listen(
      //   (eventData) {
      //     final rawData = utf8.decode(eventData, allowMalformed: true);
      //     final dataList = rawData.split('\n').where((element) => element.isNotEmpty).toList();
      //     for (final line in dataList) {
      //       if (line.startsWith('data: ')) {
      //         final data = line.substring(6);
      //         if (data.contains('"status":"requires_action"')) {
      //           log(data);
      //           try {
                //   final b = 'r"""$data"""';
                  // Map<String, dynamic> a = json.decode(data);
                  // RunModel result = RunModel.fromJson(a);
                  // message += (result.delta?.content.first.text?.value ?? '');
                  // streamController.sink.add(message);
                  // log('$a');
      //           } catch (e) {
      //             log(e.toString());
      //           }
      //         }
      //       }
      //     }
      //   },
      // )
      //     // .asFuture()
      //     // .whenComplete(
            // () => add(FetchMessages(thread: event.thread)),
      //     // )
      //     ;
       // final streamController = StreamController<String>.broadcast(
  //   onListen: () async {
  //     await Future.delayed(const Duration(milliseconds: 200));
  //   },
  // );