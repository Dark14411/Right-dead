import 'package:flame/components.dart';
import '../player.dart';
import '../menu_game.dart';
import '../enemy_manager.dart';

class GameScreen extends PositionComponent
    with HasGameReference<MenuGame> {
  late SpriteComponent gameBackground;
  late Player player;
  late EnemyManager enemyManager;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Establecer tamaño del componente
    size = game.size;
    position = Vector2.zero();

    // Cargar la imagen del escenario
    final sprite = await Sprite.load('escenario.png');

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

    gameBackground = SpriteComponent(
      sprite: sprite,
      size: displaySize,
      position: displayPosition,
    );

    add(gameBackground);

    // El jugador aparece en la parte superior-central (defendiendo desde arriba)
    player = Player()
      ..position = Vector2(game.size.x / 2, game.size.y * 0.3);
    add(player);

    enemyManager = EnemyManager();
    add(enemyManager);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;

    if (gameBackground.sprite != null) {
      final imageSize = gameBackground.sprite!.srcSize;
      final screenRatio = size.x / size.y;
      final imageRatio = imageSize.x / imageSize.y;

      Vector2 displaySize;

      if (screenRatio > imageRatio) {
        displaySize = Vector2(size.y * imageRatio, size.y);
      } else {
        displaySize = Vector2(size.x, size.x / imageRatio);
      }

      gameBackground.size = displaySize;
      gameBackground.position = Vector2(
        (size.x - displaySize.x) / 2,
        (size.y - displaySize.y) / 2,
      );
    }
  }
}