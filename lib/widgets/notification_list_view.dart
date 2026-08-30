import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/notification_model.dart';

/// शेअर्ड नोटिफिकेशन लिस्ट — Admin/CP/Franchise/Seller/Buyer सर्वांसाठी वापरतो.
/// क्लिक केल्यावर ते "वाचलेलं" होतं आणि आपोआप यादीत खाली सरकतं (न वाचलेली आधी दिसतात).
class NotificationListView extends StatefulWidget {
  final List<NotificationModel> notifications;
  const NotificationListView({super.key, required this.notifications});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late List<NotificationModel> _items;

  @override
  void initState() {
    super.initState();
    _items = List.of(widget.notifications);
  }

  void _handleTap(NotificationModel n) {
    setState(() {
      n.isRead = true;
      _items.sort((a, b) => (a.isRead ? 1 : 0).compareTo(b.isRead ? 1 : 0));
    });
    n.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_none_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('सध्या कोणतीही सूचना नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final n = _items[index];
        return GestureDetector(
          onTap: () => _handleTap(n),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: n.isRead ? Colors.white : n.color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: n.isRead ? Colors.grey.shade200 : n.color.withValues(alpha: 0.25)),
              boxShadow: n.isRead ? [] : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: n.color.withValues(alpha: n.isRead ? 0.06 : 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(n.icon, color: n.isRead ? n.color.withValues(alpha: 0.6) : n.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(child: Text(n.title, style: TextStyle(fontWeight: n.isRead ? FontWeight.w500 : FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
                        if (!n.isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.errorRed, shape: BoxShape.circle)),
                      ]),
                      const SizedBox(height: 3),
                      Text(n.desc, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),
                      const SizedBox(height: 4),
                      Text(n.time, style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                ),
                if (n.onTap != null) Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
          ),
        );
      },
    );
  }
}
