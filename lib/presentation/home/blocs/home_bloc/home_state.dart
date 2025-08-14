part of 'home_bloc.dart';

class HomeState {
  final List<AssistantModel> listAssistant;
  HomeState({
    required this.listAssistant,
  });
}

class HomeInitial extends HomeState {
  HomeInitial({required super.listAssistant});
}

class HomeSuccess extends HomeState {
  HomeSuccess({required super.listAssistant});
}

class HomeError extends HomeState {
  final String errorMessage;
  HomeError({
    required this.errorMessage,
    required super.listAssistant,
  });
}
