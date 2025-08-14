part of 'conversation_bloc.dart';

class ConversationEvent {}

class FetchThreads extends ConversationEvent {}

class DeleteThread extends ConversationEvent {
  final ThreadModel thread;
  DeleteThread({
    required this.thread,
  });
}

class DeleteAllThread extends ConversationEvent {}
