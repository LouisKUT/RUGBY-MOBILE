class Playlist {
  final String id;
  final String title;
  final String image;
  final String description;

  Playlist({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
    id: json['id'],
    title: json['snippet']['title'],
    image: json['snippet']['thumbnails']['standard']['url'],
    description: json['snippet']['description'],
  );
}