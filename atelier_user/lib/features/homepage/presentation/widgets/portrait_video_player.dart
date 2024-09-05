import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PortraitVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const PortraitVideoPlayer({Key? key, required this.controller}) : super(key: key);

  @override
  _PortraitVideoPlayerState createState() => _PortraitVideoPlayerState();
}

class _PortraitVideoPlayerState extends State<PortraitVideoPlayer> {
// late VideoPlayerController _controller = widget.controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: VideoPlayer(widget.controller)),
    );
  }
}
