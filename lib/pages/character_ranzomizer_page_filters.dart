import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_randomizer/components/custom_padding_widget.dart';
import 'package:valorant_randomizer/components/grouped_by_widget.dart';
import 'package:valorant_randomizer/models/character_model.dart';

import '../blocs/character_randomizer/character_randomizer_page_roulette_bloc.dart';

class CharacterRandomizerPageFilterWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  const CharacterRandomizerPageFilterWidget(
      {super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    double scaleW = MediaQuery.of(context).size.width / 1920;
    double scaleH = MediaQuery.of(context).size.height / 1080;
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
      const DropdownMenuEntry<int>(
        value: 1,
        label: "Selecionados",
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
      ),
      const DropdownMenuEntry<int>(
        value: 2,
        label: "Classe",
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
        ),
      ),
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
      padding: EdgeInsets.symmetric(
        horizontal: 8.0 * scaleW,
        vertical: 8.0 * scaleH,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        children: [
          const CustomPaddingWidget(
            child: Text("Buscar: "),
          ),
          CustomPaddingWidget(
            child: DropdownMenu<int?>(
              initialSelection: 1,
              controller: characterSelectionNumberController,
              dropdownMenuEntries: characterSelecionNumberEntries,
            ),
          ),
          GroupedByWidget(
            items: characterSelecionGroupTypeEntries,
            controller: characterSelectionGroupTypeController,
          ),
          CustomPaddingWidget(
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
