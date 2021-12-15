import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:youtube_app/models/video_model.dart';

class FavoriteBloc implements BlocBase {
  late Map<String, VideoModel> _favorites;

  final _favController = BehaviorSubject<Map<String, VideoModel>>();

  Stream<Map<String, VideoModel>> get outFavorites => _favController.stream;

  void toggleFavorite(VideoModel video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);

    saveFavorites();
  }

  FavoriteBloc() {
    _favorites = <String, VideoModel>{};

    SharedPreferences.getInstance().then((value) {
      if (value.getKeys().contains("favorites")) {
        _favorites = json.decode(value.getString("favorites")!).map((k, v) {
          return MapEntry(k, VideoModel.fromMap(v));
        }).cast<String, VideoModel>();
      }

      _favController.add(_favorites);
    });
  }

  void saveFavorites() {
    SharedPreferences.getInstance().then(
      (value) => {
        value.setString(
          "favorites",
          json.encode(_favorites),
        ),
      },
    );
  }

  @override
  void dispose() {
    _favController.close();
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
