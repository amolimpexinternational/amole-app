import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/local_posts_data.dart';
import 'new_post_screen.dart';

class MyWallScreen extends StatefulWidget {
  const MyWallScreen({super.key});

  @override
  State<MyWallScreen> createState() => _MyWallScreenState();
}

class _MyWallScreenState extends State<MyWallScreen> {
  void _goToNewPost() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPostScreen()));
  }

  void _toggleLike(LocalPost post) {
    setState(() {
      post.likedByMe = !post.likedByMe;
      post.likes += post.likedByMe ? 1 : -1;
    });
  }

  void _addComment(LocalPost post) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Comment लिहा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'तुमची प्रतिक्रिया लिहा...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    setState(() => post.comments += 1);
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.send, color: AppColors.primaryBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _sharePost(LocalPost post) {
    setState(() => post.shares += 1);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('पोस्ट Share झाली!'), backgroundColor: Colors.green),
    );
  }

  Widget _buildMediaPlaceholder(PostMediaType type) {
    IconData icon;
    String label;
    switch (type) {
      case PostMediaType.photo:
        icon = Icons.image_outlined;
        label = 'फोटो';
        break;
      case PostMediaType.video:
        icon = Icons.play_circle_fill;
        label = 'व्हिडिओ';
        break;
      case PostMediaType.text:
        return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 44, color: AppColors.textLight),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPostCard(LocalPost post) {
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
                child: Text(post.authorName.isNotEmpty ? post.authorName[0] : '?',
                    style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                    Text(post.timeLabel, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ),
              if (post.isViral)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 14),
                      SizedBox(width: 2),
                      Text('Viral', style: TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(post.text, style: const TextStyle(fontSize: 14, color: AppColors.textDark, height: 1.4)),
          _buildMediaPlaceholder(post.mediaType),
          const SizedBox(height: 10),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _toggleLike(post),
                  icon: Icon(
                    post.likedByMe ? Icons.thumb_up : Icons.thumb_up_outlined,
                    size: 16,
                    color: post.likedByMe ? AppColors.primaryBlue : AppColors.textLight,
                  ),
                  label: Text('${post.likes}', style: TextStyle(color: post.likedByMe ? AppColors.primaryBlue : AppColors.textLight, fontSize: 12)),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _addComment(post),
                  icon: const Icon(Icons.chat_bubble_outline, size: 16, color: AppColors.textLight),
                  label: Text('${post.comments}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _sharePost(post),
                  icon: const Icon(Icons.share_outlined, size: 16, color: AppColors.textLight),
                  label: Text('${post.shares}', style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // सर्वात नवीन पोस्ट सर्वात वर — Facebook-प्रकारे फीड (Blueprint ४.१०)
    final posts = List<LocalPost>.from(LocalPostsData.posts)
      ..sort((a, b) => b.postedAt.compareTo(a.postedAt));

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text('My Wall', style: TextStyle(color: AppColors.textDark)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: _goToNewPost,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: const Text('पोस्ट करा', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: posts.length,
          itemBuilder: (context, index) => _buildPostCard(posts[index]),
        ),
      ),
    );
  }
}
