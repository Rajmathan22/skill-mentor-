class Story {
  final String id;
  final String pseudo;
  final String? profileimg;
  final List<String> storyUrls;
  final bool isLiked;
  final bool isMineStory; // Add this

  Story({
    required this.id,
    required this.pseudo,
    required this.profileimg,
    required this.storyUrls,
    required this.isLiked,
    this.isMineStory = false, // Default to false
  });

  Story copyWith({
    String? id,
    String? pseudo,
    String? profileimg,
    List<String>? storyUrls,
    bool? isLiked,
    bool? isMineStory,
  }) {
    return Story(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      profileimg: profileimg ?? this.profileimg,
      storyUrls: storyUrls ?? this.storyUrls,
      isLiked: isLiked ?? this.isLiked,
      isMineStory: isMineStory ?? this.isMineStory,
    );
  }
}
