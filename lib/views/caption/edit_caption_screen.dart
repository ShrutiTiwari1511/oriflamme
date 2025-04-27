import 'package:flutter/material.dart';
import 'package:oriflamme/core/utils/app_constants.dart';

class EditCaptionScreen extends StatefulWidget {
  final String id;
  final String initialCaption;
  final String initialHashtag;
  final String initialReferral;
  final void Function({
    required String id,
    required String caption,
    required String hashtag,
    required String referral,
  }) onSave;

  const EditCaptionScreen({
    Key? key,
    required this.id,
    required this.initialCaption,
    required this.initialHashtag,
    required this.initialReferral,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late TextEditingController _captionController;
  late TextEditingController _hashtagController;
  late TextEditingController _referralController;

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: widget.initialCaption);
    _hashtagController = TextEditingController(text: widget.initialHashtag);
    _referralController = TextEditingController(text: widget.initialReferral);

    _captionController.addListener(_checkIfTextChanged);
    _hashtagController.addListener(_checkIfTextChanged);
    _referralController.addListener(_checkIfTextChanged);
  }

  @override
  void dispose() {
    _captionController.dispose();
    _hashtagController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  void _checkIfTextChanged() {
    bool hasChanged = _captionController.text.trim() != widget.initialCaption.trim() ||
        _hashtagController.text.trim() != widget.initialHashtag.trim() ||
        _referralController.text.trim() != widget.initialReferral.trim();

    setState(() {
      isButtonEnabled = hasChanged;
    });
  }

  void _handleSave() {
    if (!isButtonEnabled) return;

    widget.onSave(
      id: widget.id,
      caption: _captionController.text.trim(),
      hashtag: _hashtagController.text.trim(),
      referral: _referralController.text.trim(),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppConstants.editCaption,
          style: TextStyle(color: AppConstants.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TextButton(
              onPressed: isButtonEnabled ? _handleSave : null,
              style: TextButton.styleFrom(
                backgroundColor: isButtonEnabled ? AppConstants.greenColor : AppConstants.greyOverlay,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                AppConstants.save,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(  
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _captionController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none, 
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _hashtagController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none, 
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _referralController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,  
              ),
            ),
          ],
        ),
      ),
    );
  }
}
