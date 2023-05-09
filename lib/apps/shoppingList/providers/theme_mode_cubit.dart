import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeCubit extends Cubit<bool> {
  ThemeModeCubit() : super(false);

  bool changeDarkMode() {
    emit(!state);
    return state;
  }
}
