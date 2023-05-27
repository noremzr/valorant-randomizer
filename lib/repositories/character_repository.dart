import 'package:valorant_randomizer/enums/character_class_enum.dart';
import 'package:valorant_randomizer/models/character_model.dart';

class CharacterRepository{

  static List<CharacterModel>  getAll(){
    List<CharacterModel> list = [];

    list.addAll([
      CharacterModel(id: "astra", name: "Astra", classType: CharacterClass.controller),
      CharacterModel(id: "breach", name: "Breach", classType: CharacterClass.initiator),
      CharacterModel(id: "brimstone", name: "Brimstone", classType: CharacterClass.controller),
      CharacterModel(id: "chamber", name: "Chamber", classType: CharacterClass.sentinel),
      CharacterModel(id: "cypher", name: "Cypher", classType: CharacterClass.sentinel),
      CharacterModel(id: "fade", name: "Fade", classType: CharacterClass.initiator),
      CharacterModel(id: "gekko", name: "Gekko", classType: CharacterClass.initiator),
      CharacterModel(id: "harbor", name: "Harbor", classType: CharacterClass.controller),
      CharacterModel(id: "jett", name: "Jett", classType: CharacterClass.duelist),
      CharacterModel(id: "kayo", name: "KAY/O", classType: CharacterClass.initiator),
      CharacterModel(id: "killjoy", name: "Killjoy", classType: CharacterClass.sentinel),
      CharacterModel(id: "neon", name: "Neon", classType: CharacterClass.duelist),
      CharacterModel(id: "omen", name: "Omen", classType: CharacterClass.controller),
      CharacterModel(id: "phoenix", name: "Phoenix", classType: CharacterClass.duelist),
      CharacterModel(id: "raze", name: "Raze", classType: CharacterClass.duelist),
      CharacterModel(id: "reyna", name: "Reyna", classType: CharacterClass.duelist),
      CharacterModel(id: "sage", name: "Sage", classType: CharacterClass.sentinel),
      CharacterModel(id: "skye", name: "Skye", classType: CharacterClass.initiator),
      CharacterModel(id: "sova", name: "Sovas", classType: CharacterClass.initiator),
      CharacterModel(id: "viper", name: "Viper", classType: CharacterClass.controller),
      CharacterModel(id: "yoru", name: "Yoru", classType: CharacterClass.duelist),
    ]);

    return list;
  }

}