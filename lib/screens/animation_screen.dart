import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnimationScreen extends Component {
  final VoidCallback onAnimationEnd;
  VideoPlayerController? videoController;
  bool isInitialized = false;

  AnimationScreen({required this.onAnimationEnd});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  Future<void> startAnimation() async {
    try {
      videoController = VideoPlayerController.asset('assets/boton-animado.mp4');
      await videoController!.initialize();
      
      videoController!.addListener(() {
        if (videoController!.value.position >= videoController!.value.duration) {
          // La animación terminó
          videoController!.dispose();
          onAnimationEnd();
        }
      });
      
      isInitialized = true;
      videoController!.play();
    } catch (e) {
      print('Error loading video: $e');
      // Si hay un error, pasar directamente al juego después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        onAnimationEnd();
      });
    }
  }

  @override
  void onRemove() {
    videoController?.dispose();
    super.onRemove();
  }
}
