import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'menu_game.dart';
import 'enemy.dart';

class Bullet extends SpriteComponent
    with HasGameReference<MenuGame>, CollisionCallbacks {
  final Vector2 velocity;

  Bullet({
    required Vector2 position,
    required this.velocity,
  }) : super(
          position: position,
          size: Vector2(16, 16),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Por ahora usar cualquier sprite pequeño o dejar sin sprite
    try {
      sprite = await Sprite.load('bullet.png');
    } catch (e) {
      // Si no existe, la bala será invisible pero funcional
    }
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Remove the bullet if it goes off-screen
    if (position.x < 0 ||
        position.x > game.size.x ||
        position.y < 0 ||
        position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
      other.removeFromParent();
    }
  }
}
