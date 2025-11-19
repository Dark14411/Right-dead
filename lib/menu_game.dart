import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';
import 'screens/options_screen.dart';
import 'screens/credits_screen.dart';
import 'screens/continue_screen.dart';
import 'screens/extra_menu_screen.dart';
import 'screens/multiplayer_screen.dart';
import 'screens/game_screen.dart';

enum GameState {
  menu,
  options,
  credits,
  resume,
  extraMenu,
  multiplayer,
  playing,
  weaponsStore,
  coinsStore,
}

class MenuGame extends FlameGame with HasCollisionDetection {
  GameState currentState = GameState.menu;

  late MenuScreen menuScreen;
  late OptionsScreen optionsScreen;
  late CreditsScreen creditsScreen;
  late ContinueScreen continueScreen;
  late ExtraMenuScreen extraMenuScreen;
  late MultiplayerScreen multiplayerScreen;
  late GameScreen gameScreen;

  @override
  Color backgroundColor() => const Color(0xFF000000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Inicializar las pantallas
    menuScreen = MenuScreen(
      onPlayPressed: showGame, // Ir directamente al juego
      onOptionsPressed: showOptions,
      onCreditsPressed: showCredits,
      onMultiplayerPressed: showMultiplayer,
    );
    optionsScreen = OptionsScreen(onBackPressed: showMenu);
    creditsScreen = CreditsScreen(onBackPressed: showMenu);
    continueScreen = ContinueScreen(
      onContinuePressed: showGame,
    ); // Por ahora va al juego
    extraMenuScreen = ExtraMenuScreen(onBackPressed: showMenu);
    multiplayerScreen = MultiplayerScreen(onBackPressed: showMenu);
    gameScreen = GameScreen();

    // Cargar la pantalla de menú
    add(menuScreen);
  }

  void showGame() {
    // Remover la pantalla anterior
    if (currentState == GameState.menu) {
      remove(menuScreen);
    } else if (currentState == GameState.resume) {
      remove(continueScreen);
    }
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

  void showExtraMenu() {
    remove(menuScreen);
    currentState = GameState.extraMenu;
    add(extraMenuScreen);
  }

  void showMultiplayer() {
    remove(menuScreen);
    currentState = GameState.multiplayer;
    add(multiplayerScreen);
  }

  void showWeaponsStore() {
    // Show weapons store overlay
    currentState = GameState.weaponsStore;
    overlays.add('weaponsStore');
  }

  void showCoinsStore() {
    // Switch from weapons store to coins store
    if (currentState == GameState.weaponsStore) {
      overlays.remove('weaponsStore');
    }
    currentState = GameState.coinsStore;
    overlays.add('coinsStore');
  }

  void closeStore() {
    // Close any active store overlay
    if (currentState == GameState.weaponsStore) {
      overlays.remove('weaponsStore');
    } else if (currentState == GameState.coinsStore) {
      overlays.remove('coinsStore');
    }
    currentState = GameState.menu;
  }

  void showMenu() {
    // Remover la pantalla actual y volver al menú
    if (currentState == GameState.options) {
      remove(optionsScreen);
    } else if (currentState == GameState.credits) {
      remove(creditsScreen);
    } else if (currentState == GameState.resume) {
      remove(continueScreen);
    } else if (currentState == GameState.extraMenu) {
      remove(extraMenuScreen);
    } else if (currentState == GameState.multiplayer) {
      remove(multiplayerScreen);
    } else if (currentState == GameState.playing) {
      remove(gameScreen);
    } else if (currentState == GameState.weaponsStore) {
      overlays.remove('weaponsStore');
    } else if (currentState == GameState.coinsStore) {
      overlays.remove('coinsStore');
    }
    currentState = GameState.menu;
    add(menuScreen);
  }
}