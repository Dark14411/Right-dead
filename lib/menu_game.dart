import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/options_screen.dart';
import 'screens/game_screen.dart';

enum GameState { menu, options, playing }

class MenuGame extends FlameGame {
  GameState currentState = GameState.menu;

  late MenuScreen menuScreen;
  late OptionsScreen optionsScreen;
  late GameScreen gameScreen;

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Inicializar las pantallas
    menuScreen = MenuScreen(
      onPlayPressed: showGame,
      onOptionsPressed: showOptions,
    );
    optionsScreen = OptionsScreen(onBackPressed: showMenu);
    gameScreen = GameScreen();

    // Cargar la pantalla de menú
    add(menuScreen);
  }

  void showGame() {
    remove(menuScreen);
    currentState = GameState.playing;
    add(gameScreen);
  }

  void showOptions() {
    remove(menuScreen);
    currentState = GameState.options;
    add(optionsScreen);
  }

  void showMenu() {
    remove(optionsScreen);
    currentState = GameState.menu;
    add(menuScreen);
  }
}
