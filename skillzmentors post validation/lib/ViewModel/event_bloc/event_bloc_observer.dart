import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event added: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Printing the current state and next state of the change
    print('State changed: Change { currentState: ${change.currentState}, nextState: ${change.nextState} }');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Printing the current state, event, and next state of the transition
    print('Transition: Transition { currentState: ${transition.currentState}, event: ${transition.event}, nextState: ${transition.nextState} }');
  }
}
