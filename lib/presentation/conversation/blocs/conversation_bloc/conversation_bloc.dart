import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_assistant/core/index.dart';
import 'package:game_assistant/data/local_store/controllers/thread_controller.dart';
import 'package:game_assistant/data/models/index.dart';
import 'package:game_assistant/repository/thread_repository.dart';
import 'package:injectable/injectable.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

@lazySingleton
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  // final ThreadRepository threadRepository = ThreadRepository();

  ConversationBloc() : super(ConversationInitial(listThread: [])) {
    on<FetchThreads>(_onFetchThreads);
    on<DeleteThread>(_onDeleteThread);
    on<DeleteAllThread>(_onDeleteAllThread);
  }

  FutureOr<void> _onFetchThreads(FetchThreads event, Emitter<ConversationState> emit) async {
    try {
      final listThread = ThreadController.getThreads();
      emit(ConversationInitial(listThread: listThread));
    } catch (e) {
      emit(ConversationError(errorMessage: e.toString(), listThread: state.listThread));
    }
  }

  FutureOr<void> _onDeleteThread(DeleteThread event, Emitter<ConversationState> emit) async {
    try {
      final currentList = [...state.listThread];
      currentList.removeWhere((element) => element.id == event.thread.id);
      emit(ConversationSuccess(listThread: currentList));
      ThreadController.deleteThread(event.thread);
      await getIt<ThreadRepository>().deleteThread(threadId: event.thread.id ?? '');
      add(FetchThreads());
    } catch (e) {
      emit(ConversationError(errorMessage: e.toString(), listThread: state.listThread));
    }
  }

  FutureOr<void> _onDeleteAllThread(DeleteAllThread event, Emitter<ConversationState> emit) async {
    try {
      await ThreadController.deleteThreads().then((value) => add(FetchThreads()));
    } catch (e) {
      emit(ConversationError(errorMessage: e.toString(), listThread: state.listThread));
    }
  }
}
