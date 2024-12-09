import 'dart:convert';

class MineStory {
  final String mineId;
  final String userName;
  final String? mineTitle;
  final String? mineContent;
  final List<MineMedia> mineMedia;
  final int likesCount;
  final bool isLiked;

  MineStory({
    required this.mineId,
    required this.userName,
    this.mineTitle,
    this.mineContent,
    required this.mineMedia,
    required this.likesCount,
    required this.isLiked,
  });

  factory MineStory.fromJson(Map<String, dynamic> json) {
    return MineStory(
      mineId: json['mine_id'] as String,
      userName: json['user_name'] as String,
      mineTitle: json['mine_title'] as String?,
      mineContent: json['mine_content'] as String?,
      mineMedia: (json['mine_media'] as List<dynamic>)
          .map((item) => MineMedia.fromJson(item as Map<String, dynamic>))
          .toList(),
      likesCount: int.parse(json['likes_count']),
      isLiked: json['is_liked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mine_id': mineId,
      'user_name': userName,
      'mine_title': mineTitle,
      'mine_content': mineContent,
      'mine_media': mineMedia.map((item) => item.toJson()).toList(),
      'likes_count': likesCount.toString(),
      'is_liked': isLiked,
    };
  }
}

class MineMedia {
  final String mediaUrl;
  final String mediaType;

  MineMedia({
    required this.mediaUrl,
    required this.mediaType,
  });

  factory MineMedia.fromJson(Map<String, dynamic> json) {
    return MineMedia(
      mediaUrl: json['media_url'] as String,
      mediaType: json['media_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'media_url': mediaUrl,
      'media_type': mediaType,
    };
  }
}
