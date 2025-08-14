part of 'navigation_bloc.dart';

class NavigationEvent {}

class NavigateToScreen extends NavigationEvent {
  final int index;
  NavigateToScreen({
    required this.index,
  });
}
