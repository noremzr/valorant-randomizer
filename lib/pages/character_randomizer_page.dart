import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/character_randomizer/character_randomizer_page_bloc.dart';
import '../blocs/character_randomizer/character_randomizer_page_roulette_bloc.dart';
import '../models/character_model.dart';
import '../repositories/character_repository.dart';
import 'adsense_widget.dart';
import 'character_randomizer_page_allcharacters.dart';
import 'character_randomizer_page_roulettes.dart';
import 'character_ranzomizer_page_filters.dart';

class CharacterRandomizerPageWidget extends StatelessWidget {
  const CharacterRandomizerPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<CharacterModel> characters = CharacterRepository.getAll();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              CharacterRandomizerPageBloc(characters),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              CharacterRandomizerPageRouletteBloc(),
        ),
      ],
      child: Column(
        children: [
          CharacterRandomizerPageFilterWidget(characters: characters),
          const CharacterRandomizerPageRoulettesWidget(),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CharacterRandomizerPageAllCharactersWidget(characters: characters),
              ),
              // const BannerAdUnit(),
            ],
          ),
          
        ],
      ),
    );
  }
}
