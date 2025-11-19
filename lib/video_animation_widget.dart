import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAnimationWidget extends StatefulWidget {
  final VoidCallback onFinished;

  const VideoAnimationWidget({super.key, required this.onFinished});

  @override
  State<VideoAnimationWidget> createState() => _VideoAnimationWidgetState();
}

class _VideoAnimationWidgetState extends State<VideoAnimationWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/boton-animado.mp4');

    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });

      // Listener para detectar cuando termina el video
      _controller.addListener(_checkVideoProgress);

      await _controller.play();
    } catch (e) {
      // Si falla, llamar a onFinished después de un breve delay
      Future.delayed(const Duration(seconds: 1), () {
        widget.onFinished();
      });
    }
  }

  void _checkVideoProgress() {
    if (!_controller.value.isPlaying &&
        _controller.value.position >=
            _controller.value.duration - const Duration(milliseconds: 100)) {
      _controller.removeListener(_checkVideoProgress);
      widget.onFinished();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
