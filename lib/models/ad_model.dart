import 'package:flutter/material.dart';

enum AdStatus { live, paused, expired }

class AdModel {
  final String id;
  String sellerName;
  String category;
  String location;
  String type; // photo | video | text
  String title;
  String desc;
  String avatar;
  Color avatarColor;
  Color bgColor1;
  Color bgColor2;
  String tag;
  String pollQuestion;
  int likes;
  int comments;
  double budget;
  int durationDays;
  double incomeGenerated;
  AdStatus status;
  DateTime createdAt;
  String createdBy;

  AdModel({
    required this.id,
    required this.sellerName,
    required this.category,
    required this.location,
    required this.type,
    required this.title,
    required this.desc,
    required this.avatar,
    required this.avatarColor,
    required this.bgColor1,
    required this.bgColor2,
    this.tag = 'Sponsored',
    this.pollQuestion = 'तुम्ही या जाहिरातीत इंटरेस्टेड आहात का?',
    this.likes = 0,
    this.comments = 0,
    this.budget = 0,
    this.durationDays = 7,
    this.incomeGenerated = 0,
    this.status = AdStatus.live,
    DateTime? createdAt,
    this.createdBy = 'admin',
  }) : createdAt = createdAt ?? DateTime.now();
}
