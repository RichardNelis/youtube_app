import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/bloc/favorite_bloc.dart';
import 'package:youtube_app/bloc/video_bloc.dart';
import 'package:youtube_app/delegates/data_search_delegate.dart';
import 'package:youtube_app/models/video_model.dart';
import 'package:youtube_app/page/favorite_page.dart';
import 'package:youtube_app/widgets/video_tile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocVideo = BlocProvider.getBloc<VideoBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset("images/logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: StreamBuilder<Map<String, VideoModel>>(
                  stream: BlocProvider.getBloc<FavoriteBloc>().outFavorites,
                  initialData: const {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("${snapshot.data!.length}");
                    } else {
                      return const Text("0");
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
                  );
                },
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? result = await showSearch(
                  context: context, delegate: DataSearchDelegate());

              if (result != null) {
                blocVideo.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<VideoModel>>(
        stream: blocVideo.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: (snapshot.data?.length)! + 1,
              itemBuilder: (context, index) {
                if (snapshot.data!.isEmpty) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  );
                }
                if (index < snapshot.data!.length) {
                  return VideoTile(video: snapshot.data![index]);
                } else {
                  blocVideo.inSearch.add("");
                  return Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
