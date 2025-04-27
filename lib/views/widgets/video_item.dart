import 'package:flutter/material.dart';
import 'package:oriflamme/core/utils/app_constants.dart';
import 'package:oriflamme/core/utils/app_images.dart';
import 'package:oriflamme/models/video_model.dart';
import 'package:oriflamme/viewmodels/home_view_model.dart';
import 'package:oriflamme/views/caption/edit_caption_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class VideoItemWidget extends StatefulWidget {
  final VideoModel videoItem;
  final ValueChanged<String> onCaptionUpdated;

  const VideoItemWidget({
    Key? key,
    required this.videoItem,
    required this.onCaptionUpdated,
  }) : super(key: key);

  @override
  _VideoItemWidgetState createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  bool isExpanded = false;
  String url = 'https://www.brandie.io';

  // method to truncate caption
  String _getTruncatedCaption(String caption, int wordCount) {
    List<String> words = caption.split(' ');
    if (words.length <= wordCount) return caption;
    return '${words.take(wordCount).join(' ')}...';
  }

  // Handle caption tap: expand if not expanded, go to edit if expanded
  void _handleCaptionTap() {
    if (isExpanded) {
      Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditCaptionScreen(
        id: widget.videoItem.id,
        initialCaption: widget.videoItem.caption,
        initialHashtag: widget.videoItem.hashtags,
        initialReferral: widget.videoItem.referrals,
        onSave: ({
          required String id,
          required String caption,
          required String hashtag,
          required String referral,
        }) {
          //updating the data
          Provider.of<HomeViewModel>(context, listen: false)
              .updateCaptionHashtagReferral(
            id: id,
            caption: caption,
            hashtags: hashtag,
            referrals: referral,
          );
        },
      ),
    ),
  );
    } else {
      setState(() {
        isExpanded = true;
      });
    }
  }

  // Handle pencil icon or edit caption tap to go to EditCaptionScreen
  void _handleEdit() {
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditCaptionScreen(
        id: widget.videoItem.id,
        initialCaption: widget.videoItem.caption,
        initialHashtag: widget.videoItem.hashtags,
        initialReferral: widget.videoItem.referrals,
        onSave: ({
          required String id,
          required String caption,
          required String hashtag,
          required String referral,
        }) {
          // this is where you update your HomeViewModel
          Provider.of<HomeViewModel>(context, listen: false)
              .updateCaptionHashtagReferral(
            id: id,
            caption: caption,
            hashtags: hashtag,
            referrals: referral,
          );
        },
      ),
    ),
  );
  }

  // Handle background tap to collapse caption
  void _handleBackgroundTap() {
    if (isExpanded) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with tap handling
        GestureDetector(
          onTap: _handleBackgroundTap,
          child: Stack(
            children: [
              // Image or video background
              Image.asset(
                widget.videoItem.imagePath,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height - 120,
                width: double.infinity,
              ),
              // Dark grey gradient overlay
              Container(
                height: MediaQuery.of(context).size.height - 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.grey[900]!.withOpacity(0.8),
                      Colors.grey[800]!.withOpacity(0.4),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Profile Picture, Ready to Share, and Subtitle
        Positioned(
          left: 16,
          top: 16,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 24,
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.videoItem.profileImage),
                  radius: 22,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ready_to_share_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.starIcon,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          AppConstants.readyToShare,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.videoItem.subtitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12,
),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Top-right counter
        Positioned(
          right: 16,
          top: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppConstants.greyOverlay,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${AppConstants.pick} ${widget.videoItem.id} ${AppConstants.ofThree}',
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),
            ),
          ),
        ),

        // Bottom Music and Caption
        Positioned(
          left: 16,
          bottom: 60,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Music info
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConstants.greyOverlay,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white),
                    const SizedBox(width: 8),
                   Expanded(
  child: RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.white),
      children: [
        const TextSpan(
          text: AppConstants.recommended,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        TextSpan(
          text: widget.videoItem.musicTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (widget.videoItem.musicSinger!.trim().isNotEmpty) ...[
          const TextSpan(
            text: AppConstants.by,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: widget.videoItem.musicSinger,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ],
    ),
  ),
),

                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Caption with tap handling
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppConstants.greyOverlay,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _handleCaptionTap,
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Text.rich(
  TextSpan(
    style: const TextStyle(color: Colors.white),
    children: [
      TextSpan(
        text: isExpanded
            ? widget.videoItem.caption
            : _getTruncatedCaption(widget.videoItem.caption, 15),
        style: const TextStyle(
          fontWeight: FontWeight.w400, 
        ),
      ),
      if (isExpanded) ...[
        const TextSpan(text: '\n'),
        TextSpan(
          text: widget.videoItem.hashtags,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        const TextSpan(text: '\n'),
        TextSpan(
          text: widget.videoItem.referrals,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
      ],
    ],
  ),
),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    GestureDetector(
      onTap: _handleCaptionTap, 
      child: Text(
        AppConstants.seeMore,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    Row(
      children: [
        GestureDetector(
          onTap: _handleEdit,
          child: const Icon(Icons.edit, color: Colors.green, size: 18),
        ),
        const SizedBox(width: 4), 
        GestureDetector(
          onTap: _handleEdit,
          child: Text(
          AppConstants.editCaption,
          style: TextStyle(color: AppConstants.whiteColor, fontSize: 14),
          ),
        ),
      ],
    ),
  ],
),

                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Quick share row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.quickShareTo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/instagram.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/whatsapp.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/whatsapp_business.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/tiktok.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/telegram.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/icon1.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/icon2.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x40FEFEFE),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/icon3.png',
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),

        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height / 2 - 150, 
          child: Container(
            width: 22,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0x90464646),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                return Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: int.parse(widget.videoItem.id) == index+1? Colors.green : Colors.white,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}