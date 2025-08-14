// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

class ChatState {
  final List<MessageModel> listMessage;
  final ThreadModel thread;
  StreamController<String>? streamController;
  ChatState({
    required this.listMessage,
    required this.thread,
    this.streamController,
  });
}

class ChatInitial extends ChatState {
  ChatInitial({
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}

class ChatLoading extends ChatState {
  ChatLoading({
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}

class ChatSearching extends ChatState {
  ChatSearching({
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}

class ChatThreadLoading extends ChatState {
  ChatThreadLoading({
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}

class ChatSuccess extends ChatState {
  ChatSuccess({
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}

class ChatError extends ChatState {
  final String errorMessage;
  ChatError({
    required this.errorMessage,
    required super.listMessage,
    required super.thread,
    super.streamController,
  });
}
