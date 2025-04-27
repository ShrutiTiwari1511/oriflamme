import 'package:flutter/material.dart';
import 'package:oriflamme/models/video_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<VideoModel> videos = [];

  HomeViewModel() {
    loadVideos();
  }

  void loadVideos() {
    videos = [
      VideoModel(
        id: '1',
        imagePath: 'assets/images/video1.png',
        caption: '💄Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25! This luxurious creamy lipstick doesnt just promise rich pigments but brings you the benefits of hyaluronic acid and collagen-boosting peptides too. Pamper your lips with care while enjoying a long-lasting, luminous matte colour. 💋 ✨',
        musicTitle: 'Bad Habits',
        musicSinger: 'Ed Sheeran',
        profileImage: 'assets/images/profile1.png',
        hashtags: '#Oriflame #GiordaniGold #LipCareGoals',
        referrals: 'Use my referral code: UK-AMANDA3012 \n Use my referral link: www.oriflame.com/giordani/amada3012',
        counterText: 'Ready to Share',
        subtitle: 'High-converting in Oriflame Community',
      ),
      VideoModel(
        id: '2',
        imagePath: 'assets/images/video2.png',
        caption: '✨ Experience the elegance of Eclat Amour—a fragrance that captures the essence of romance and sophistication. Let every spritz wrap you in timeless charm and effortless allure. 💕',
        musicTitle: 'Shape of You',
        musicSinger: '',
        hashtags: '#EclatAmour #TimelessElegance',
        referrals: 'Use my referral code: UK-AMANDA3012 \n Use my referral link: www.oriflame.com/giordani/amada3012',
        profileImage: 'assets/images/profile1.png',
        counterText: 'Ready to Share',
        subtitle: 'Join the Oriflame Movement',
      ),
      VideoModel(
        id: '3',
        imagePath: 'assets/images/video3.png',
        caption: 'Unlock the power of bold, beautiful lashes! With WonderLash Mascara, get ultimate length, volume, and definition for a stunning, eye-catching look. One swipe is all it takes! 💖',
        musicTitle: 'Perfect',
        musicSinger: 'Ed Sheeran',
        hashtags: '#WonderLash #LashesForDays',
        referrals: 'Use my referral code: UK-AMANDA3012 \n Use my referral link: www.oriflame.com/giordani/amada3012',
        profileImage: 'assets/images/profile1.png',
        counterText: 'Ready to Share',
        subtitle: 'Your Community Awaits',
      ),
    ];
    notifyListeners();
  }
  void updateCaptionHashtagReferral({
  required String id,
  required String caption,
  required String hashtags,
  required String referrals,
}) {
  final index = videos.indexWhere((v) => v.id == id);
  if (index == -1) return; 

  videos[index] = videos[index].copyWith(
    caption: caption,
    hashtags: hashtags,
    referrals: referrals,
  );

  notifyListeners();
}

  
}
