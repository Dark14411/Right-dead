import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'menu_game.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<MenuGame>, CollisionCallbacks {
  Enemy() : super(size: Vector2(128, 128));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await Flame.images.load('Personajes/Enemigo1/Walk Cycle (Ciclo de Caminar).png');
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(64, 64),
      ),
    );
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Los enemigos suben desde abajo hacia arriba (hacia la antena)
    position.y -= 50 * dt; // Negativo para subir

    // Si llega al techo, el jugador pierde
    if (position.y < 0) {
      game.showMenu(); // Game Over - los zombis llegaron a la antena
      removeFromParent();
    }
  }
}
