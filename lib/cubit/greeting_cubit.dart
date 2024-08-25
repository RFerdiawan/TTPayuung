import 'package:flutter_bloc/flutter_bloc.dart';

class GreetingCubit extends Cubit<GreetingState> {
  GreetingCubit() : super(GreetingState(greeting: 'Selamat pagi'));

  void updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      emit(GreetingState(greeting: 'Selamat Pagi'));
    } else if (hour < 15) {
      emit(GreetingState(greeting: 'Selamat Siang'));
    } else if (hour < 18) {
      emit(GreetingState(greeting: 'Selamat Sore'));
    } else {
      emit(GreetingState(greeting: 'Selamat Malam'));
    }
  }
}

class GreetingState {
  final String greeting;

  GreetingState({required this.greeting});
}
