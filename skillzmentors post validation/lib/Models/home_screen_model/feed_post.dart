class FeedDataModel {
  final String id;
  final String pseudo;
  final String photo;
  final String time;
  final String photoProfile;
  final String description;
  final String? likes; // Ensure this is a String
  final bool isLiked;

  FeedDataModel({
    required this.id,
    required this.pseudo,
    required this.photo,
    required this.time,
    required this.photoProfile,
    required this.description,
    this.likes,
    required this.isLiked,
  });

  FeedDataModel copyWith({
    String? id,
    String? pseudo,
    String? photo,
    String? time,
    String? photoProfile,
    String? description,
    String? likes,
    bool? isLiked,
  }) {
    return FeedDataModel(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      photo: photo ?? this.photo,
      time: time ?? this.time,
      photoProfile: photoProfile ?? this.photoProfile,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
