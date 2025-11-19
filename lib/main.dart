import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'menu_game.dart';
import 'screens/final_menu_armas.dart';
import 'screens/final_menu_monedas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Happy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GameWidget<MenuGame>(
        game: MenuGame(),
        overlayBuilderMap: {
          'weaponsStore': (BuildContext context, MenuGame game) {
            return FinalMenuArmas(
              onClose: () {
                game.closeStore();
              },
              onShowCoinsStore: () {
                game.showCoinsStore();
              },
            );
          },
          'coinsStore': (BuildContext context, MenuGame game) {
            return FinalMenuMonedas(
              onClose: () {
                game.closeStore();
              },
            );
          },
        },
      ),
    );
  }
}
