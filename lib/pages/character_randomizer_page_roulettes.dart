import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_randomizer/blocs/character_randomizer/character_randomizer_page_bloc.dart';

import '../blocs/character_randomizer/character_randomizer_page_roulette_bloc.dart';
import '../models/character_model.dart';

class CharacterRandomizerPageRoulettesWidget extends StatelessWidget {
  const CharacterRandomizerPageRoulettesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CharacterRandomizerPageRouletteBloc rouletteBloc =
        context.read<CharacterRandomizerPageRouletteBloc>();
    final CharacterRandomizerPageBloc bloc =
        context.read<CharacterRandomizerPageBloc>();
    return BlocBuilder<CharacterRandomizerPageBloc,
            CharacterRandomizerPageState>(
        bloc: bloc,
        builder: (context, statePageBLoc) {
          return BlocBuilder(
            bloc: rouletteBloc,
            builder: (context, state) {
              if (state is CharacterRandomizerPageRouletteRoulettedState) {
                return Wrap(
                  children: getRoulettes(statePageBLoc.characters,
                      state.charactersSorted, context, true, rouletteBloc),
                );
              } else if (state
                  is CharacterRandomizerPageRouletteRoulettedSucessfullState) {
                return Wrap(
                  children: getRoulettes(statePageBLoc.characters,
                      state.charactersSorted, context, false, rouletteBloc),
                );
              } else {
                return Container();
              }
            },
          );
        });
  }

  List<Widget> getRoulettes(
      List<CharacterModel> allCharacters,
      List<CharacterModel> charactersSorted,
      BuildContext context,
      bool makeAnimation,
      CharacterRandomizerPageRouletteBloc rouletteBloc) {
    List<Widget> roulettes = [];
    for (CharacterModel characterSorted in charactersSorted) {
      ScrollController controller = ScrollController(keepScrollOffset: true);
      roulettes.add(getRoulette(allCharacters, controller, context));
      if (makeAnimation) {
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
      } else {
        Future.delayed(
          Duration(
            milliseconds: 1 * (charactersSorted.indexOf(characterSorted) + 1),
          ),
          () => resizeWindow(
            controller,
            allCharacters.indexOf(characterSorted),
            context,
          ),
        );
      }
    }
    if (makeAnimation) {
      Future.delayed(
          const Duration(seconds: 7),
          () => rouletteBloc.add(
              CharacterRandomizerPageRouletteSetRouletesSucessfullEvent(
                  charactersSorted: charactersSorted)));
    }
    return roulettes;
  }

  Widget getRoulette(List<CharacterModel> characters,
      ScrollController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width / 12,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: characters.length,
            itemExtent: MediaQuery.of(context).size.height / 12,
            controller: controller,
            itemBuilder: (context, index) {
              return Image.asset(
                'assets/character_icons/${characters[index].id}.png',
                height: MediaQuery.of(context).size.height / 12,
                width: MediaQuery.of(context).size.width / 12,
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
          (MediaQuery.of(context).size.height / 12.0),
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

  void resizeWindow(
    ScrollController controller,
    int indexSelecionado,
    BuildContext context,
  ) {
    controller.jumpTo(
      indexSelecionado * MediaQuery.of(context).size.height / 12.0,
    );
  }
}
