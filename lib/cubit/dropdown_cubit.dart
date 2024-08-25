import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit extends Cubit<Map<String, String?>> {
  DropdownCubit() : super({});

  void selectItem(String key, String? value) {
    emit({...state, key: value});
  }
}
