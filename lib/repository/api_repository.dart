import 'package:dio/dio.dart';
import 'package:youtube_app/models/video_model.dart';
import 'package:youtube_app/utils/constants.dart';

class APIRepository {
  late Dio _dio;

  late String _search;
  late String _nextToken;

  APIRepository() {
    _dio = Dio();
  }

  Future<List<VideoModel>> search(String search) async {
    _search = search;

    String url = urlAPI +
        "search?" +
        "q=$_search" +
        "&part=snippet" +
        "&type=video" +
        "&maxResults=10" +
        "&key=$apiKey";

    Response response = await _dio.get(url);

    return _decode(response);
  }

  Future<List<VideoModel>> nextPage() async {
    String url = urlAPI +
        "search?" +
        "q=$_search" +
        "&part=snippet" +
        "&type=video" +
        "&maxResults=10" +
        "&pageToken=$_nextToken" +
        "&key=$apiKey";

    Response response = await _dio.get(url);

    return _decode(response);
  }

  List<VideoModel> _decode(Response response) {
    List<VideoModel> videos = [];

    switch (response.statusCode) {
      case 200:
        _nextToken = response.data["nextPageToken"];

        videos = List<VideoModel>.from(
          response.data["items"].map(
            (map) => VideoModel.fromMap(map),
          ),
        );

        break;
    }

    return videos;
  }
}
