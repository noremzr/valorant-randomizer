import '../enums/character_class_enum.dart';

class CharacterModel {
  String id;

  String name;

  CharacterClass classType;

  bool selected = true;

  CharacterModel(
      {required this.id,
      required this.name,
      required this.classType,
      this.selected = true});
}
