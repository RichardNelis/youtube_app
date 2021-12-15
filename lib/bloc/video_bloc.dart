import 'dart:async';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_app/models/video_model.dart';

import 'package:youtube_app/repository/api_repository.dart';

class VideoBloc implements BlocBase {
  late APIRepository _apiRepository;
  late List<VideoModel> videos;

  final _videoController = BehaviorSubject<List<VideoModel>>();
  Stream<List<VideoModel>> get outVideos => _videoController.stream;

  final _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    _apiRepository = APIRepository();

    _searchController.stream.listen((event) {
      _search(event);
    });
  }

  Future<void> _search(String search) async {
    if (search.isNotEmpty) {
      _videoController.sink.add([]);
      videos = await _apiRepository.search(search);
    } else {
      videos.addAll(await _apiRepository.nextPage());
    }

    if (videos.isNotEmpty) {
      _videoController.sink.add(videos);
    }
  }

  @override
  void dispose() {
    _videoController.close();
    _searchController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
