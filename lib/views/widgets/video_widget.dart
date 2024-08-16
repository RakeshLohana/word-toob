import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatefulWidget {
  String videoPath;
  VideoThumbnail(this.videoPath);

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: InkWell(
        child: _controller.value.isInitialized
            ? Container(
          width: 100.0,
          height: 56.0,
          child: VideoPlayer(_controller),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
        onTap: () {
        },
      ),
    );
  }
}