import 'package:bloc/bloc.dart';

import '../../models/character_model.dart';
import '../../services/character_service.dart';

class CharacterRandomizerPageRouletteBloc extends Bloc<
    CharacterRandomizerPageRouletteEvent,
    CharacterRandomizerPageRouletteState> {
  CharacterRandomizerPageRouletteBloc()
      : super(CharacterRandomizerPageRouletteInitialState()) {
    on<CharacterRandomizerPageRouletteSetRouletesEvent>((event, emit) {
      List<CharacterModel> charactersSorted =
          CharacterService.getCharactersByFilter(event.numberOfCharacters,
              event.typeOfSearch, event.charactersSelected);

      emit(CharacterRandomizerPageRouletteRoulettedState(
          charactersSorted: charactersSorted));
    });
  }
}

abstract class CharacterRandomizerPageRouletteState {
  CharacterRandomizerPageRouletteState();
}

class CharacterRandomizerPageRouletteInitialState
    extends CharacterRandomizerPageRouletteState {
  CharacterRandomizerPageRouletteInitialState();
}

class CharacterRandomizerPageRouletteRoulettedState
    extends CharacterRandomizerPageRouletteState {
  List<CharacterModel> charactersSorted;

  CharacterRandomizerPageRouletteRoulettedState(
      {required this.charactersSorted});
}

abstract class CharacterRandomizerPageRouletteEvent {}

class CharacterRandomizerPageRouletteSetRouletesEvent
    extends CharacterRandomizerPageRouletteEvent {
  int numberOfCharacters;

  String typeOfSearch;

  List<CharacterModel> charactersSelected;

  CharacterRandomizerPageRouletteSetRouletesEvent(
      {required this.numberOfCharacters,
      required this.typeOfSearch,
      required this.charactersSelected});
}
