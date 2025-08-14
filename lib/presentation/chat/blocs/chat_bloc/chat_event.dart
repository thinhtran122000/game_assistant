part of 'chat_bloc.dart';

class ChatEvent {}

class FetchMessages extends ChatEvent {
  ThreadModel? thread;
  FetchMessages({
    this.thread,
  });
}

class CreateThread extends ChatEvent {
  AssistantModel? assistant;
  CreateThread({
    this.assistant,
  });
}

class CreateRun extends ChatEvent {
  ThreadModel? thread;
  AssistantModel? assistant;
  CreateRun({
    this.thread,
    this.assistant,
  });
}

class CreateMessage extends ChatEvent {
  final ThreadModel thread;
  final String message;
  final Function(ThreadModel) onCallback;

  CreateMessage({
    required this.thread,
    required this.message,
    required this.onCallback,
  });
}

class DeleteMessage extends ChatEvent {
  final ThreadModel thread;
  final String messageId;
  DeleteMessage({
    required this.thread,
    required this.messageId,
  });
}
