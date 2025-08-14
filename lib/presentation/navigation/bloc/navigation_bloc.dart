import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

@lazySingleton
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(NavigationInitial(
          index: 0,
          screens: ['Home', 'Chat'],
        )) {
    on<NavigateToScreen>(_onNavigateToScreen);
  }

  FutureOr<void> _onNavigateToScreen(NavigateToScreen event, Emitter<NavigationState> emit) {
    emit(NavigationInitial(
      index: event.index,
      screens: state.screens,
    ));
  }
}
