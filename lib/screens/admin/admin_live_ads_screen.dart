import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/ads_data.dart';
import '../../models/ad_model.dart';
import 'admin_edit_ad_screen.dart';
import 'admin_create_ad_screen.dart';

class AdminLiveAdsScreen extends StatefulWidget {
  final String? locationKeyword;
  final String title;
  const AdminLiveAdsScreen({
    super.key,
    this.locationKeyword,
    this.title = 'Live असणाऱ्या जाहिराती',
  });

  @override
  State<AdminLiveAdsScreen> createState() => _AdminLiveAdsScreenState();
}

class _AdminLiveAdsScreenState extends State<AdminLiveAdsScreen> {
  late List<AdModel> _ads;

  @override
  void initState() {
    super.initState();
    _reloadAds();
  }

  void _reloadAds() {
    final source = widget.locationKeyword == null
        ? AdsData.liveAds
        : AdsData.liveAds
            .where((a) => a.location.contains(widget.locationKeyword!))
            .toList();
    _ads = List.from(source);
  }

  // === Preview dialog ===
  void _previewAd(AdModel ad) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, ctrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.visibility, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('जाहिरात Preview',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: ctrl,
                padding: const EdgeInsets.all(16),
                children: [
                  // Ad preview card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.royalBlue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.25),
                              child: Text(
                                ad.avatar,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ad.sellerName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(ad.location,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Text('LIVE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(ad.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _section('📋 जाहिरात तपशील', [
                    _infoRow('शीर्षक', ad.title),
                    _infoRow('कोणी टाकली', ad.sellerName),
                    _infoRow('क्षेत्र', ad.location),
                    _infoRow('Income Generated',
                        '₹${ad.incomeGenerated.toStringAsFixed(0)}'),
                  ]),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.live_tv, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'ही जाहिरात आत्ता Live आहे — सर्व युजर्सना दिसत आहे.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AdminEditAdScreen(ad: ad)),
                    ).then((_) {
                      if (mounted) setState(() {});
                    });
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('संपूर्ण Edit करा',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Delete ===
  void _deleteAd(AdModel ad) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('जाहिरात हटवायची?'),
        content: Text('"${ad.title}" कायमची हटवली जाईल.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('रद्द')),
          ElevatedButton(
            onPressed: () {
              setState(() => _ads.remove(ad));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('🗑️ जाहिरात हटवली'),
                    backgroundColor: Colors.red),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('हटवा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textLight)),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  // === Card ===
  Widget _buildCard(AdModel ad) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: ad.avatarColor.withValues(alpha: 0.15),
                child: Text(ad.avatar,
                    style: TextStyle(
                        color: ad.avatarColor, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textDark)),
                    Text('${ad.sellerName} • ${ad.location}',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textLight)),
                    const SizedBox(height: 4),
                    Text(
                      'Income: ₹${ad.incomeGenerated.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.successGreen,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('Live',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ✅ Preview (primary) + Edit icon + Delete icon
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _previewAd(ad),
                  icon: const Icon(Icons.visibility,
                      size: 16, color: Colors.white),
                  label: const Text('Preview',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.edit_outlined,
                    size: 20, color: AppColors.primaryBlue),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AdminEditAdScreen(ad: ad)),
                  );
                  if (mounted) setState(() {});
                },
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline,
                    size: 20, color: Colors.red),
                onPressed: () => _deleteAd(ad),
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = _ads.fold(0.0, (sum, a) => sum + a.incomeGenerated);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          // ✅ "+" काढलं — फक्त "Create New Ad"
          TextButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AdminCreateAdScreen()),
              );
              if (mounted) setState(() => _reloadAds());
            },
            child: const Text(
              'Create New Ad',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Text('${_ads.length}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue)),
                    const Text('एकूण Live जाहिराती',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textLight)),
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Text('₹${totalIncome.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.successGreen)),
                    const Text('एकूण Income',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textLight)),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: _ads.isEmpty
                ? const Center(
                    child: Text('या भागात सध्या कुठलीही Live जाहिरात नाही',
                        style: TextStyle(color: AppColors.textLight)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _ads.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) => _buildCard(_ads[i]),
                  ),
          ),
        ],
      ),
    );
  }
}