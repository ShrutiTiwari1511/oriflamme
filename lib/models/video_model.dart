// lib/models/video_model.dart

class VideoModel {
  final String id;
  final String imagePath;     
  final String caption;
  final String musicTitle;     
  final String? musicSinger;
  final String hashtags;
  final String referrals;
  final String profileImage;
  final String counterText;   
  final String subtitle;

  VideoModel({
    required this.id,
    required this.imagePath,
    required this.caption,
    required this.musicTitle,
    this.musicSinger,
    required this.hashtags,
    required this.referrals,
    required this.profileImage,
    required this.counterText,
    required this.subtitle,
  });
  VideoModel copyWith({
    String? id,
    String? imagePath,
    String? caption,
    String? musicTitle,
    String? musicSinger,
    String? profileImage,
    String? hashtags,
    String? referrals,
    String? counterText,
    String? subtitle,
  }) {
    return VideoModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      caption: caption ?? this.caption,
      musicTitle: musicTitle ?? this.musicTitle,
      musicSinger: musicSinger ?? this.musicSinger,
      profileImage: profileImage ?? this.profileImage,
      hashtags: hashtags ?? this.hashtags,
      referrals: referrals ?? this.referrals,
      counterText: counterText ?? this.counterText,
      subtitle: subtitle ?? this.subtitle,
    );
  }
}
