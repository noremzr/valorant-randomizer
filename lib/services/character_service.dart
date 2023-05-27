import 'dart:math';

import '../enums/character_class_enum.dart';
import '../models/character_model.dart';

class CharacterService {
  static List<CharacterModel> getCharactersByFilter(int numberOfCharacters,
      String typeOfSearch, List<CharacterModel> charactersSelected) {
    if (typeOfSearch == 'Selecionados') {
      return getCharactersSelected(numberOfCharacters, charactersSelected);
    } else {
      return getCharactersSelectedClasses(
          numberOfCharacters, charactersSelected);
    }
  }

  static List<CharacterModel> getCharactersSelected(
      int numberOfCharacters, List<CharacterModel> charactersSelected) {
    List<CharacterModel> charactersSorted = [];
    List<int> sortedNumbers = [];
    while (numberOfCharacters > 0) {
      int sortedNumber = Random().nextInt(charactersSelected.length);
      if (!sortedNumbers.contains(sortedNumber)) {
        charactersSorted.add(charactersSelected[sortedNumber]);
        sortedNumbers.add(sortedNumber);
        numberOfCharacters--;
      }
    }
    return charactersSorted;
  }

  static List<CharacterModel> getCharactersSelectedClasses(
      int numberOfCharacters, List<CharacterModel> charactersSelected) {
    List<CharacterModel> charactersSorted = [];
    List<int> sortedNumbers = [];
    while (numberOfCharacters > 0) {
      for (CharacterClass characterClass in CharacterClass.values) {
        List<CharacterModel> charactersClass = charactersSelected
            .where((element) => element.classType == characterClass)
            .toList();
        int sortedNumber = Random().nextInt(charactersClass.length);
        int realNumber =
            charactersSelected.indexOf(charactersClass[sortedNumber]);
        while (sortedNumbers.contains(realNumber)) {
          sortedNumber = Random().nextInt(charactersClass.length);
          realNumber =
              charactersSelected.indexOf(charactersClass[sortedNumber]);
        }
        charactersSorted.add(charactersSelected[realNumber]);
        sortedNumbers.add(realNumber);
        if (CharacterClass.values.last == characterClass) {
          numberOfCharacters--;
        }
      }
    }
    return charactersSorted;
  }
}
