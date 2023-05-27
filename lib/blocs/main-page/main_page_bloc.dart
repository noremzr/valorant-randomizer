import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class MainPageBloc extends Bloc<MainPageChangeThemeEvent, MainPageState> {
  MainPageBloc(ThemeData theme) : super(MainPageInitialState(theme: theme)) {
    on<MainPageChangeThemeEvent>(
        (event, emit) => emit(MainPageChangeThemeState(theme: event.theme)));
  }
}

abstract class MainPageState {
  ThemeData theme;

  MainPageState({required this.theme});
}

class MainPageInitialState extends MainPageState {
  MainPageInitialState({required ThemeData theme}) : super(theme: theme);
}

class MainPageChangeThemeState extends MainPageState {
  MainPageChangeThemeState({required ThemeData theme}) : super(theme: theme);
}

abstract class MainPageEvent {}

class MainPageChangeThemeEvent extends MainPageEvent {
  ThemeData theme;

  MainPageChangeThemeEvent({required this.theme});
}
