class Video {
  final String id;
  final String title;

  Video({
    required this.id,
    required this.title
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json['snippet']['resourceId']['videoId'],
    title: json['snippet']['title'],
  );
}