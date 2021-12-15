import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/bloc/favorite_bloc.dart';
import 'package:youtube_app/models/video_model.dart';
import 'package:youtube_app/widgets/video_favorite_widget.dart';
import 'package:youtube_app/widgets/video_player_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocFavorite = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: blocFavorite.outFavorites,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return const Text("Não tem nenhum vídeo favorito!");
              }

              var video = snapshot.data!.values.toList()[index];

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerWidget(video: video),
                    ),
                  );
                },
                onLongPress: () {
                  blocFavorite.toggleFavorite(video);
                },
                child: VideoFavoriteWidget(video: video),
              );
            },
          );
        },
      ),
    );
  }
}
