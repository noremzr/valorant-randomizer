import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/character_randomizer/character_randomizer_page_roulette_bloc.dart';
import '../models/character_model.dart';

class CharacterRandomizerPageRoulettesWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  const CharacterRandomizerPageRoulettesWidget(
      {super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    final CharacterRandomizerPageRouletteBloc rouletteBloc =
        context.read<CharacterRandomizerPageRouletteBloc>();
    return BlocBuilder(
      bloc: rouletteBloc,
      builder: (context, state) {
        if (state is CharacterRandomizerPageRouletteRoulettedState) {
          return Wrap(
            children: getRoulettes(characters, state.charactersSorted, context),
          );
        } else {
          return Container();
        }
      },
    );
  }

  List<Widget> getRoulettes(List<CharacterModel> allCharacters,
      List<CharacterModel> charactersSorted, BuildContext context) {
    List<Widget> roulettes = [];

    for (CharacterModel characterSorted in charactersSorted) {
      ScrollController controller = ScrollController();
      roulettes.add(getRoulette(allCharacters, controller, context));
      Future.delayed(
        Duration(
          milliseconds: 200 * (charactersSorted.indexOf(characterSorted) + 1),
        ),
        () => animateToIndex(
          controller,
          allCharacters.length - 1,
          allCharacters.indexOf(characterSorted),
          context,
        ),
      );
    }
    return roulettes;
  }

  Widget getRoulette(List<CharacterModel> characters,
      ScrollController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 8,
        width: 110,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: characters.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/character_icons/${characters[index].id}.png',
                height: MediaQuery.of(context).size.height / 8,
              );
            },
          ),
        ),
      ),
    );
  }

  void animateToIndex(ScrollController controller, int maxNumber,
      int indexSelecionado, BuildContext context,
      {int times = 3}) {
    controller
        .animateTo(
      (times > 0 ? maxNumber : indexSelecionado) *
          MediaQuery.of(context).size.height /
          8,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linear,
    )
        .then((value) {
      if (times > 0) {
        times -= 1;
        controller.jumpTo(0);
        animateToIndex(controller, maxNumber, indexSelecionado, context,
            times: times);
      }
    });
  }
}
