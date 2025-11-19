import 'dart:math';
import 'package:flame/components.dart';
import 'menu_game.dart';
import 'enemy.dart';

class EnemyManager extends Component with HasGameReference<MenuGame> {
  late Timer _timer;
  final Random _random = Random();

  EnemyManager() {
    _timer = Timer(2, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    final enemy = Enemy()
      ..x = _random.nextDouble() * game.size.x
      ..y = game.size.y; // Aparecen en la parte inferior de la pantalla
    game.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
