import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'menu_game.dart';
import 'bullet.dart';
import 'enemy.dart';

enum PlayerState { idle, running, attacking }

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<MenuGame>, CollisionCallbacks, KeyboardHandler {
  Player() : super(size: Vector2(50, 50), anchor: Anchor.center);
  
  final double speed = 200.0;
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadAnimations();
    current = PlayerState.idle;
    add(RectangleHitbox());
  }

  Future<void> _loadAnimations() async {
    // Cargar imágenes manualmente desde assets
    final idleImage = await _loadImage('assets/Personajes/Personaje 1/Personaje1(Con Arma)/Idle (inactivo).png');
    final runningImage = await _loadImage('assets/Personajes/Personaje 1/Personaje1(Con Arma)/Run Cycle (ciclo de carrera).png');
    final shootImage = await _loadImage('assets/Personajes/Personaje 1/Personaje1(Con Arma)/disparo en línea recta (standing shoot).png');

    final idleAnimation = SpriteAnimation.fromFrameData(
      idleImage,
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.15,
        textureSize: Vector2(102.4, 1024),
      ),
    );

    final runningAnimation = SpriteAnimation.fromFrameData(
      runningImage,
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.1,
        textureSize: Vector2(102.4, 1024),
      ),
    );

    final shootAnimation = SpriteAnimation.fromFrameData(
      shootImage,
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2(341.33, 1024),
        loop: false,
      ),
    );

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.attacking: shootAnimation,
    };
  }

  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  void attack() {
    current = PlayerState.attacking;
    Future.delayed(const Duration(milliseconds: 400), () {
      current = PlayerState.idle;
    });
  }

  void shoot() {
    final bullet = Bullet(
      position: position + Vector2(size.x / 2, size.y / 2),
      velocity: Vector2(scale.x * 500, 0),
    );
    game.add(bullet);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity = Vector2.zero();
    
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -speed;
      scale.x = -1;
      current = PlayerState.running;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = speed;
      scale.x = 1;
      current = PlayerState.running;
    } else {
      current = PlayerState.idle;
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      shoot();
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      attack();
    }
    
    return true;
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    
    // Mantener dentro de los límites de la pantalla
    if (position.x < 0) position.x = 0;
    if (position.x > game.size.x) position.x = game.size.x;
    if (position.y < 0) position.y = 0;
    if (position.y > game.size.y) position.y = game.size.y;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      game.showMenu();
    }
  }
}
