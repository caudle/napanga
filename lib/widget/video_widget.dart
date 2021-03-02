import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  VideoWidget({@required this.videoPlayerController});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  ChewieController _chewieController;

  @override
  void initState() {
    _initializePlayer();
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    await widget.videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController.videoPlayerController.value.initialized
        ? Chewie(
            controller: _chewieController,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
  }
}
