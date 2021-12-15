class VideoModel {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("id")) {
      return VideoModel(
        id: map["id"]["videoId"],
        title: map["snippet"]["title"],
        thumb: map["snippet"]["thumbnails"]["high"]["url"],
        channel: map["snippet"]["channelTitle"],
      );
    } else {
      return VideoModel(
        id: map["videoId"],
        title: map["title"],
        thumb: map["thumb"],
        channel: map["channel"],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel,
    };
  }
}
