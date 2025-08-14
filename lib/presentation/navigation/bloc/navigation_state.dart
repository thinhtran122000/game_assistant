part of 'navigation_bloc.dart';

class NavigationState {
  final List<String> screens;
  final int index;
  NavigationState({
    required this.screens,
    required this.index,
  });
}

class NavigationInitial extends NavigationState {
  NavigationInitial({
    required super.index,
    required super.screens,
  });
}
