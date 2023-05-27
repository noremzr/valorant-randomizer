import 'package:bloc/bloc.dart';

import '../../models/character_model.dart';

class CharacterRandomizerPageBloc
    extends Bloc<CharacterRandomizerPageEvent, CharacterRandomizerPageState> {
  CharacterRandomizerPageBloc(List<CharacterModel> characters)
      : super(CharacterRandomizerPageInitialState(characters: characters)) {
    on<CharacterRandomizerPageSetSelectedEvent>((event, emit) {
      CharacterModel character = characters
          .where((character) => character.id == event.characterId)
          .first;

      character.selected = !character.selected;

      emit(CharacterRandomizerPageInitialState(characters: characters));
    });
  }
}

abstract class CharacterRandomizerPageState {
  List<CharacterModel> characters;

  CharacterRandomizerPageState({required this.characters});
}

class CharacterRandomizerPageInitialState extends CharacterRandomizerPageState {
  CharacterRandomizerPageInitialState(
      {required List<CharacterModel> characters})
      : super(characters: characters);
}

abstract class CharacterRandomizerPageEvent {}

class CharacterRandomizerPageSetSelectedEvent
    extends CharacterRandomizerPageEvent {
  String characterId;

  CharacterRandomizerPageSetSelectedEvent({required this.characterId});
}
