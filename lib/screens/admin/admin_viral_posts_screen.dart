import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/local_posts_data.dart';

class AdminViralPostsScreen extends StatefulWidget {
  const AdminViralPostsScreen({super.key});

  @override
  State<AdminViralPostsScreen> createState() => _AdminViralPostsScreenState();
}

class _AdminViralPostsScreenState extends State<AdminViralPostsScreen> {
  static const int _viralThreshold = 1000;

  @override
  Widget build(BuildContext context) {
    final viral = LocalPostsData.posts.where((p) => p.responsePoints >= _viralThreshold).toList()
      ..sort((a, b) => b.responsePoints.compareTo(a.responsePoints));

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Most Viral पोस्ट'),
      ),
      body: viral.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_fire_department_outlined, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  Text('अजून कुठलीही पोस्ट $_viralThreshold+ Response Points पर्यंत पोहोचलेली नाही', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textLight)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: viral.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final post = viral[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: Text(post.authorName.isNotEmpty ? post.authorName[0] : '?', style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold))),
                        const SizedBox(width: 10),
                        Expanded(child: Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.deepOrange.shade50, borderRadius: BorderRadius.circular(20)),
                          child: Row(children: [
                            const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 14),
                            const SizedBox(width: 2),
                            Text('${post.responsePoints}', style: const TextStyle(color: Colors.deepOrange, fontSize: 11, fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Text(post.text, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      const Divider(height: 20),
                      Row(children: [
                        Icon(Icons.thumb_up_outlined, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text('${post.likes}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        const SizedBox(width: 14),
                        Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text('${post.comments}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        const SizedBox(width: 14),
                        Icon(Icons.share_outlined, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text('${post.shares}', style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('पोस्ट Remove करण्याचा अधिकार Admin कडे आहे (TODO: Firestore delete)')),
                            );
                          },
                          icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red),
                          label: const Text('Remove', style: TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      ]),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
