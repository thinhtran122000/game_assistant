import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoItem extends StatefulWidget {
  final List<String> videos;
  const VideoItem({
    super.key,
    this.videos = const [],
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late YoutubePlayerController? controller;

  @override
  void initState() {
    controller = widget.videos.isEmpty
        ? YoutubePlayerController()
        : YoutubePlayerController.fromVideoId(
            videoId: YoutubePlayerController.convertUrlToId(widget.videos[0]) ?? '',
            autoPlay: false,
            params: const YoutubePlayerParams(),
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    return widget.videos.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: YoutubePlayer(
                aspectRatio: 5 / 4,
                controller: controller ?? YoutubePlayerController(),
              ),
            ),
          );
  }

  @override
  void dispose() {
    controller = null;
    controller?.close();
    super.dispose();
  }
}
