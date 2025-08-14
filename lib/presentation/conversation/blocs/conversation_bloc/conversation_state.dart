part of 'conversation_bloc.dart';

class ConversationState {
  final List<ThreadModel> listThread;
  ConversationState({
    required this.listThread,
  });
}

class ConversationInitial extends ConversationState {
  ConversationInitial({
    required super.listThread,
  });
}

class ConversationSuccess extends ConversationState {
  ConversationSuccess({
    required super.listThread,
  });
}

class ConversationError extends ConversationState {
  final String errorMessage;
  ConversationError({
    required this.errorMessage,
    required super.listThread,
  });
}
