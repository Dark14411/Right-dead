import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/options_screen.dart';
import 'screens/credits_screen.dart';
import 'screens/continue_screen.dart';
import 'screens/game_screen.dart';

enum GameState { menu, options, credits, resume, playing }

class MenuGame extends FlameGame {
  GameState currentState = GameState.menu;

  late MenuScreen menuScreen;
  late OptionsScreen optionsScreen;
  late CreditsScreen creditsScreen;
  late ContinueScreen continueScreen;
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
      onCreditsPressed: showCredits,
    );
    optionsScreen = OptionsScreen(onBackPressed: showMenu);
    creditsScreen = CreditsScreen(onBackPressed: showMenu);
    continueScreen = ContinueScreen(onContinuePressed: showGame); // Por ahora va al juego
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

  void showCredits() {
    remove(menuScreen);
    currentState = GameState.credits;
    add(creditsScreen);
  }

  void showResume() {
    remove(menuScreen);
    currentState = GameState.resume;
    add(continueScreen);
  }

  void showMenu() {
    // Remover la pantalla actual y volver al menú
    if (currentState == GameState.options) {
      remove(optionsScreen);
    } else if (currentState == GameState.credits) {
      remove(creditsScreen);
    } else if (currentState == GameState.resume) {
      remove(continueScreen);
    }
    currentState = GameState.menu;
    add(menuScreen);
  }
}
