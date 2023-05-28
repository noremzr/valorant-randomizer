import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/character_randomizer/character_randomizer_page_bloc.dart';
import '../enums/character_class_enum.dart';
import '../models/character_model.dart';

class CharacterRandomizerPageAllCharactersWidget extends StatelessWidget {
  final List<CharacterModel> characters;
  const CharacterRandomizerPageAllCharactersWidget(
      {super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    final CharacterRandomizerPageBloc bloc =
        context.read<CharacterRandomizerPageBloc>();

    return Column(children: [
      Row(
        children: getClassTypeCards(bloc, context),
      ),
      BlocBuilder<CharacterRandomizerPageBloc, CharacterRandomizerPageState>(
        bloc: bloc,
        builder: (context, state) {
          return Row(
            children: getAllCardsFromClasses(
                context, CharacterClass.values, bloc, state.characters),
          );
        },
      )
    ]);
  }

  List<Widget> getClassTypeCards(
      CharacterRandomizerPageBloc bloc, BuildContext context) {
    List<Widget> widgets =
        getClassTypeCard(CharacterClass.values, bloc, context);
    return widgets;
  }

  List<Widget> getClassTypeCard(List<CharacterClass> characterClasses,
      CharacterRandomizerPageBloc bloc, BuildContext context) {
    List<Widget> widgets = [];
    for (CharacterClass characterClass in characterClasses) {
      Widget widget = Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.matrix((<double>[
                -1.0, 0.0, 0.0, 0.0, 255.0, //
                0.0, -1.0, 0.0, 0.0, 255.0, //
                0.0, 0.0, -1.0, 0.0, 255.0, //
                0.0, 0.0, 0.0, 1.0, 0.0, //
              ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          bool selected = false;
                          List<CharacterModel> charactersClass = characters
                              .where((character) =>
                                  character.classType == characterClass)
                              .toList();
                          for (CharacterModel character in charactersClass) {
                            if (character == charactersClass.first) {
                              selected = character.selected;
                            }
                            character.selected = selected;
                            bloc.add(
                              CharacterRandomizerPageSetSelectedEvent(
                                  characterId: character.id),
                            );
                          }
                        },
                        child: Image.asset(
                          'assets/class_type/${characterClass.name}.png',
                          height: MediaQuery.of(context).size.height / 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      widgets.add(widget);
    }
    return widgets;
  }

  List<Widget> getAllCardsFromClasses(
      BuildContext context,
      List<CharacterClass> characterClasses,
      CharacterRandomizerPageBloc bloc,
      List<CharacterModel> characters) {
    List<Widget> widgets = [];

    for (CharacterClass characterClass in characterClasses) {
      Widget widget = Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: getCardsFromCharacters(
                    getCharactersModelFromList(characterClass, characters),
                    bloc,
                    context),
              ),
            ],
          ),
        ),
      );
      widgets.add(widget);
    }

    return widgets;
  }

  List<CharacterModel> getCharactersModelFromList(
      CharacterClass characterClass, List<CharacterModel> list) {
    return list
        .where((element) => element.classType == characterClass)
        .toList();
  }

  List<Widget> getCardsFromCharacters(List<CharacterModel> characters,
      CharacterRandomizerPageBloc bloc, BuildContext context) {
    List<Widget> widgets = [];
    for (var character in characters) {
      double opacity = 1;
      if (!character.selected) {
        opacity = 0.3;
      }
      Widget card = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => bloc.add(
            CharacterRandomizerPageSetSelectedEvent(characterId: character.id),
          ),
          child: Opacity(
            opacity: opacity,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/character_icons/${character.id}.png',
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      widgets.add(card);
    }

    return widgets;
  }
}
