import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_randomizer/models/character_model.dart';

import '../blocs/character_randomizer/character_randomizer_page_roulette_bloc.dart';

class CharacterRandomizerPageFilterWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  const CharacterRandomizerPageFilterWidget(
      {super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    final CharacterRandomizerPageRouletteBloc rouletteBloc =
        context.read<CharacterRandomizerPageRouletteBloc>();
    final List<DropdownMenuEntry<int?>> characterSelecionNumberEntries =
        <DropdownMenuEntry<int?>>[];
    final TextEditingController characterSelectionNumberController =
        TextEditingController();

    characterSelecionNumberEntries.addAll([
      const DropdownMenuEntry<int>(value: 1, label: "1"),
      const DropdownMenuEntry<int>(value: 2, label: "2"),
      const DropdownMenuEntry<int>(value: 3, label: "3"),
      const DropdownMenuEntry<int>(value: 4, label: "4"),
    ]);

    final List<DropdownMenuEntry<int?>> characterSelecionGroupTypeEntries =
        <DropdownMenuEntry<int?>>[];
    final TextEditingController characterSelectionGroupTypeController =
        TextEditingController();

    characterSelecionGroupTypeEntries.addAll([
      const DropdownMenuEntry<int>(value: 1, label: "Selecionados"),
      const DropdownMenuEntry<int>(value: 2, label: "Classe"),
    ]);

    void roulette() {
      rouletteBloc.add(CharacterRandomizerPageRouletteSetRouletesEvent(
          numberOfCharacters:
              int.parse(characterSelectionNumberController.value.text),
          typeOfSearch: characterSelectionGroupTypeController.value.text,
          charactersSelected:
              characters.where((element) => element.selected).toList()));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Buscar: "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<int?>(
              initialSelection: 1,
              controller: characterSelectionNumberController,
              dropdownMenuEntries: characterSelecionNumberEntries,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Agrupado por: "),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<int?>(
              initialSelection: 1,
              enableSearch: false,
              enableFilter: false,
              controller: characterSelectionGroupTypeController,
              dropdownMenuEntries: characterSelecionGroupTypeEntries,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => roulette(),
              child: const Text("Roletar"),
            ),
          )
        ],
      ),
    );
  }
}
