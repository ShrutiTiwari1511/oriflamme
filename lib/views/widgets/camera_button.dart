import 'package:flutter/material.dart';
import 'package:oriflamme/core/utils/app_constants.dart';

class CameraButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const CameraButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        Material(
          color: AppConstants.greenColor,
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        const Text(
          'Camera',
          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
