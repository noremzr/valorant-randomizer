import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_randomizer/blocs/main-page/main_page_bloc.dart';
import 'package:valorant_randomizer/pages/character_randomizer_page.dart';
import 'package:valorant_randomizer/services/theme_service.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final MainPageBloc mainPageBloc;

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    mainPageBloc =
        MainPageBloc(isDarkMode ? ThemeService.dark() : ThemeService.light());
  }

  @override
  void dispose() {
    mainPageBloc.close();
    super.dispose();
  }

  Future<void> abrirURL() async {
    html.window.open('https://twitch.tv/noremz', "_blank");
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return BlocBuilder<MainPageBloc, MainPageState>(
      bloc: mainPageBloc,
      builder: (context, state) => MaterialApp(
        theme: state.theme,
        debugShowCheckedModeBanner: false,
        home: Title(
          title: "Valorant Randomizer",
          color: Colors.red,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Randomizador'),
              actions: <Widget>[
                IconButton(
                  style: style,
                  onPressed: () {
                    abrirURL();
                  },
                  icon: Image.asset("assets/images/twitch-logo.png"),
                  iconSize: 100,
                  splashRadius: 25,
                ),
                IconButton(
                  style: style,
                  onPressed: () {
                    mainPageBloc.add(MainPageChangeThemeEvent(
                        theme: state.theme == ThemeService.light()
                            ? ThemeService.dark()
                            : ThemeService.light()));
                  },
                  icon: Icon(state.theme == ThemeService.light()
                      ? Icons.sunny
                      : Icons.brightness_2),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  isAntiAlias: true,
                  image: const AssetImage("assets/background/background.png"),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.dstATop,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const CharacterRandomizerPageWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
