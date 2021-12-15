import 'package:flutter/material.dart';
import 'package:youtube_app/models/video_model.dart';

class VideoFavoriteWidget extends StatelessWidget {
  final VideoModel video;

  const VideoFavoriteWidget({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 50,
          child: Image.network(video.thumb),
        ),
        Expanded(
          child: Text(
            video.title,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        )
      ],
    );
  }
}
