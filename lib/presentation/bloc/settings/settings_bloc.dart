import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, ThemeMode> {
  SettingsBloc(super.initialState) {
    on<ChangeTheme>(_changeTheme);
  }

  void _changeTheme(_, Emitter<ThemeMode> emit) {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }
}
