import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../menu_game.dart';

class MenuScreen extends PositionComponent
    with TapCallbacks, HasGameReference<MenuGame> {
  final VoidCallback onPlayPressed;
  final VoidCallback onOptionsPressed;
  final VoidCallback onCreditsPressed;
  final VoidCallback onMultiplayerPressed;
  late SpriteComponent menuBackground;

  MenuScreen({
    required this.onPlayPressed,
    required this.onOptionsPressed,
    required this.onCreditsPressed,
    required this.onMultiplayerPressed,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Establecer tamaño del componente
    size = game.size;
    position = Vector2.zero();

    // Cargar la imagen del menú
    final sprite = await Sprite.load('Menu.png');

    // Calcular tamaño manteniendo aspecto (como video de YouTube)
    final imageSize = sprite.srcSize;
    final screenRatio = game.size.x / game.size.y;
    final imageRatio = imageSize.x / imageSize.y;

    Vector2 displaySize;
    Vector2 displayPosition;

    if (screenRatio > imageRatio) {
      // Pantalla más ancha - ajustar a la altura
      displaySize = Vector2(game.size.y * imageRatio, game.size.y);
    } else {
      // Pantalla más alta - ajustar al ancho
      displaySize = Vector2(game.size.x, game.size.x / imageRatio);
    }

    // Centrar la imagen
    displayPosition = Vector2(
      (game.size.x - displaySize.x) / 2,
      (game.size.y - displaySize.y) / 2,
    );

    menuBackground = SpriteComponent(
      sprite: sprite,
      size: displaySize,
      position: displayPosition,
    );

    add(menuBackground);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Detectar en qué región se hizo clic
    final tapY = event.localPosition.y;
    final screenHeight = game.size.y;
    
    // Dividir la pantalla en 6 regiones verticales iguales
    final regionHeight = screenHeight / 6;
    final regionIndex = (tapY / regionHeight).floor();
    
    // Mapear cada región a una acción
    switch (regionIndex) {
      case 0:
      case 1:
        // Región superior (primeras dos franjas) - JUGAR
        onPlayPressed();
        break;
      case 2:
        // Región central-superior - CONTINUAR (va al juego también)
        onPlayPressed();
        break;
      case 3:
        // Región central - MULTIJUGADOR
        onMultiplayerPressed();
        break;
      case 4:
        // Región central-inferior - OPCIONES
        onOptionsPressed();
        break;
      case 5:
        // Región inferior - CRÉDITOS
        onCreditsPressed();
        break;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;

    if (menuBackground.sprite != null) {
      final imageSize = menuBackground.sprite!.srcSize;
      final screenRatio = size.x / size.y;
      final imageRatio = imageSize.x / imageSize.y;

      Vector2 displaySize;

      if (screenRatio > imageRatio) {
        displaySize = Vector2(size.y * imageRatio, size.y);
      } else {
        displaySize = Vector2(size.x, size.x / imageRatio);
      }

      menuBackground.size = displaySize;
      menuBackground.position = Vector2(
        (size.x - displaySize.x) / 2,
        (size.y - displaySize.y) / 2,
      );
    }
  }
}