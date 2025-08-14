part of 'home_bloc.dart';

class HomeEvent {}

class FetchAssistants extends HomeEvent {}

class CreateAssistant extends HomeEvent {
  final String gameName;
  final String imageGame;
  CreateAssistant({
    required this.gameName,
    required this.imageGame,
  });
}

class DeleteAssistant extends HomeEvent {
  final String assistantId;
  DeleteAssistant({
    required this.assistantId,
  });
}
