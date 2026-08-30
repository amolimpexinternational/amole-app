import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
  final String time;
  bool isRead;
  final VoidCallback? onTap;

  NotificationModel({
    required this.id,
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
    required this.time,
    this.isRead = false,
    this.onTap,
  });
}
