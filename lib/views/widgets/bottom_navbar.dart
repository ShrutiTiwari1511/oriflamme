import 'package:flutter/material.dart';
import 'package:oriflamme/core/utils/app_constants.dart';
import 'package:oriflamme/core/utils/app_images.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.rocket,
              color: AppConstants.whiteColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.search, color: AppConstants.whiteColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.home, color: AppConstants.greenColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.comments, color: AppConstants.whiteColor),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppImages.profile, color: AppConstants.whiteColor),
            label: '',
          ),
        ],
      ),
    );
  }
}