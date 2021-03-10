import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:napanga/core/constants.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLooping;
  final bool isColor;
  VideoWidget(
      {@required this.videoPlayerController,
      this.isLooping = false,
      this.isColor = false});
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
      looping: widget.isLooping,
      materialProgressColors: widget.isColor
          ? ChewieProgressColors(
              playedColor: kGreen,
              bufferedColor: kGreen,
              handleColor: kGreen,
              backgroundColor: kGreen)
          : ChewieProgressColors(),
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
