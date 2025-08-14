import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';


class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Event: ${transition.event.runtimeType}');
    super.onTransition(bloc, transition);
  }
}
