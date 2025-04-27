import 'package:flutter/material.dart';
import 'package:oriflamme/core/utils/app_constants.dart';
import 'package:oriflamme/core/utils/app_images.dart';
import 'package:oriflamme/viewmodels/home_view_model.dart';
import 'package:oriflamme/views/widgets/bottom_navbar.dart';
import 'package:oriflamme/views/widgets/camera_button.dart';
import 'package:oriflamme/views/widgets/video_item.dart';
import 'package:provider/provider.dart';

class MenuRow extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const MenuRow({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.asMap().entries.map((entry) {
        int idx = entry.key;
        String item = entry.value;
        return GestureDetector(
          onTap: () => onItemSelected(idx),
          child: Text(
            item,
            style: TextStyle(
              color: idx == selectedIndex ? Colors.green : Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14,

            ),
          ),
        );
      }).toList(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center, 
                    colors: [
                      Colors.black.withOpacity(0.8), 
                      Colors.grey[900]!.withOpacity(0.6),
                      Colors.transparent, 
                    ],
                    stops: [0.0, 0.5, 1.0], 
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  backgroundImage: AssetImage(AppImages.aiAssistant),
                                  radius: 20,
                                ),
                                SizedBox(height: 4),
                                Text(AppConstants.aiAssistant, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Image.asset(AppImages.appLogo, width: 100),
                            CameraButton(onPressed: () {
                            }),
                          ],
                        ),
                        SizedBox(height: 10),
                        MenuRow(
                          items: [AppConstants.smartPost, AppConstants.library, AppConstants.communities, AppConstants.shareAndWin],
                          selectedIndex: 0,
                          onItemSelected: (index) {
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer<HomeViewModel>(
                      builder: (_, viewModel, __) {
                        return PageView.builder(
  scrollDirection: Axis.vertical,
  //making the scroll infinite
  itemBuilder: (context, index) {
    final video = viewModel.videos[index % viewModel.videos.length]; // 🔥 Loop around
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: VideoItemWidget(
          videoItem: video,
          onCaptionUpdated: (String value) {},
        ),
      ),
    );
  },
);
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: BottomNavBar(
                    selectedIndex: 0,
                    onItemTapped: (index) {
                    },
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}