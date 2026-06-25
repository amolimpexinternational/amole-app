import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _photoAdded = false;

  bool get _canPost => _textController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_canPost) {
      // TODO: Firebase Storage + Firestore जोडल्यावर खरी पोस्ट इथे save होईल
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('नवीन पोस्ट', style: TextStyle(color: AppColors.textDark)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _canPost ? _submitPost : null,
              child: Text(
                'पोस्ट करा',
                style: TextStyle(
                  color: _canPost ? AppColors.primaryBlue : AppColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.lightGrey,
                    child: Icon(Icons.person, color: AppColors.textLight),
                  ),
                  const SizedBox(width: 10),
                  const Text('तुम्ही', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textController,
                maxLines: 6,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'काय चालू आहे? तुमच्या परिसरातल्या लोकांसोबत शेअर करा...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
              ),
              if (_photoAdded) ...[
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.image_outlined, size: 48, color: AppColors.textLight),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => setState(() => _photoAdded = false),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.close, size: 16, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.lightGrey)),
                ),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => setState(() => _photoAdded = true),
                      icon: const Icon(Icons.image_outlined, color: AppColors.primaryBlue),
                      label: const Text('फोटो जोडा', style: TextStyle(color: AppColors.primaryBlue)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
