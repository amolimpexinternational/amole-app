import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'new_post_screen.dart';

class MyWallScreen extends StatefulWidget {
  const MyWallScreen({super.key});

  @override
  State<MyWallScreen> createState() => _MyWallScreenState();
}

class _MyWallScreenState extends State<MyWallScreen> {
  final List<Map<String, String>> _posts = [
    {'name': 'सुनिता पाटील', 'time': '2 तासांपूर्वी', 'text': 'कोणाला चांगला इलेक्ट्रिशियन माहिती आहे का? घरी काम आहे.', 'image': ''},
    {'name': 'राहुल शिंदे', 'time': '5 तासांपूर्वी', 'text': 'आज स्थानिक बाजारात ताजी भाजी मिळाली, खूप छान दर्जा!', 'image': 'photo'},
    {'name': 'प्रिया देशमुख', 'time': '1 दिवसांपूर्वी', 'text': 'AMOLE मुळे माझ्या परिसरातल्या दुकानांची माहिती मिळाली, खूप उपयोगी App आहे.', 'image': ''},
  ];

  void _goToNewPost() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPostScreen()));
  }

  Widget _buildPostCard(Map<String, String> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.person, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                    Text(post['time']!, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(post['text']!, style: const TextStyle(fontSize: 14, color: AppColors.textDark, height: 1.4)),
          if (post['image'] == 'photo') ...[
            const SizedBox(height: 10),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.image_outlined, size: 48, color: AppColors.textLight),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('My Wall', style: TextStyle(color: AppColors.textDark)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: _goToNewPost,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _posts.length,
          itemBuilder: (context, index) => _buildPostCard(_posts[index]),
        ),
      ),
    );
  }
}
