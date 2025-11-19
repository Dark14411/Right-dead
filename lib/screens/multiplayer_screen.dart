import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../menu_game.dart';

class MultiplayerScreen extends PositionComponent
    with TapCallbacks, HasGameReference<MenuGame> {
  final VoidCallback onBackPressed;
  late SpriteComponent multiplayerBackground;

  MultiplayerScreen({required this.onBackPressed});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Establecer tamaño del componente
    size = game.size;
    position = Vector2.zero();

    // Cargar la imagen de multijugador
    final sprite = await Sprite.load('Multijugador(in).png');

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

    multiplayerBackground = SpriteComponent(
      sprite: sprite,
      size: displaySize,
      position: displayPosition,
    );

    add(multiplayerBackground);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Al hacer clic en cualquier parte de multijugador, volver al menú
    onBackPressed();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;

    if (multiplayerBackground.sprite != null) {
      final imageSize = multiplayerBackground.sprite!.srcSize;
      final screenRatio = size.x / size.y;
      final imageRatio = imageSize.x / imageSize.y;

      Vector2 displaySize;

      if (screenRatio > imageRatio) {
        displaySize = Vector2(size.y * imageRatio, size.y);
      } else {
        displaySize = Vector2(size.x, size.x / imageRatio);
      }

      multiplayerBackground.size = displaySize;
      multiplayerBackground.position = Vector2(
        (size.x - displaySize.x) / 2,
        (size.y - displaySize.y) / 2,
      );
    }
  }
}