import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MenuScreen extends PositionComponent
    with TapCallbacks, HasGameRef<FlameGame> {
  final VoidCallback onPlayPressed;
  late SpriteComponent menuBackground;

  MenuScreen({required this.onPlayPressed});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Establecer tamaño del componente
    size = gameRef.size;
    position = Vector2.zero();

    // Cargar la imagen del menú
    final sprite = await Sprite.load('Menu.png');

    // Calcular tamaño manteniendo aspecto (como video de YouTube)
    final imageSize = sprite.srcSize;
    final screenRatio = gameRef.size.x / gameRef.size.y;
    final imageRatio = imageSize.x / imageSize.y;

    Vector2 displaySize;
    Vector2 displayPosition;

    if (screenRatio > imageRatio) {
      // Pantalla más ancha - ajustar a la altura
      displaySize = Vector2(gameRef.size.y * imageRatio, gameRef.size.y);
    } else {
      // Pantalla más alta - ajustar al ancho
      displaySize = Vector2(gameRef.size.x, gameRef.size.x / imageRatio);
    }

    // Centrar la imagen
    displayPosition = Vector2(
      (gameRef.size.x - displaySize.x) / 2,
      (gameRef.size.y - displaySize.y) / 2,
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
    // Al hacer clic en cualquier parte del menú, iniciar el juego
    onPlayPressed();
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = newSize;

    if (menuBackground.sprite != null) {
      final imageSize = menuBackground.sprite!.srcSize;
      final screenRatio = newSize.x / newSize.y;
      final imageRatio = imageSize.x / imageSize.y;

      Vector2 displaySize;

      if (screenRatio > imageRatio) {
        displaySize = Vector2(newSize.y * imageRatio, newSize.y);
      } else {
        displaySize = Vector2(newSize.x, newSize.x / imageRatio);
      }

      menuBackground.size = displaySize;
      menuBackground.position = Vector2(
        (newSize.x - displaySize.x) / 2,
        (newSize.y - displaySize.y) / 2,
      );
    }
  }
}
