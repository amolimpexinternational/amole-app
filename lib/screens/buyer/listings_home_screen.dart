import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/listings_data.dart';
import 'listing_post_screen.dart';
import 'my_listings_screen.dart';

// module: 'resalerent' (Resale Or Rent) किंवा 'jobs' (Jobs पोर्टल)
class ListingsHomeScreen extends StatefulWidget {
  final String module;
  const ListingsHomeScreen({super.key, required this.module});

  @override
  State<ListingsHomeScreen> createState() => _ListingsHomeScreenState();
}

class _ListingsHomeScreenState extends State<ListingsHomeScreen> {
  String _section = 'resale';
  String _query = '';

  bool get _isJobs => widget.module == 'jobs';
  String get _type => _isJobs ? 'job' : _section;
  List<String> get _myTypes => _isJobs ? ['job'] : ['resale', 'rent'];

  bool _match(Map<String, dynamic> p, String q) {
    if (q.isEmpty) return true;
    final v = p['values'] as Map;
    final text = '${ListingStore.title(p)} ${v['keywords']} ${v['where']}'
        .toLowerCase();
    return text.contains(q.toLowerCase());
  }

  List<Map<String, dynamic>> get _results {
    final q = _query.trim();
    return ListingStore.active(_type).where((p) => _match(p, q)).toList();
  }

  String get _postLabel {
    if (_type == 'job') return 'Job Alert post करा';
    if (_type == 'rent') return 'स्वतः Rent ने द्या';
    return 'Resale करा';
  }

  void _openPost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ListingPostScreen(type: _type)),
    ).then((_) => setState(() {}));
  }

  void _openMine() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyListingsScreen(types: _myTypes)),
    ).then((_) => setState(() {}));
  }

  void _showDetail(Map<String, dynamic> p) {
    final fields = ListingData.fields[p['type']]!;
    final v = p['values'] as Map;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.all(20),
          children: [
            Text(ListingStore.title(p),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 4),
            Text('मीडिया: ${p['media']} फोटो/व्हिडिओ',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textLight)),
            const Divider(height: 24),
            ...fields.where((f) => !f.media).map((f) {
              final val = '${v[f.key] ?? ''}';
              if (val.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(f.label,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                    Text(val,
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.textDark)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _card(Map<String, dynamic> p) {
    final icon = _type == 'job'
        ? Icons.work_outline
        : (_type == 'rent' ? Icons.key_outlined : Icons.sell_outlined);
    return GestureDetector(
      onTap: () => _showDetail(p),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ListingStore.title(p),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(ListingStore.subtitle(p),
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textLight)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(_isJobs ? '💼 Jobs' : '🔁 Resale Or Rent',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: _isJobs ? 'जॉब शोधा (keyword)...' : 'शोधा (keyword)...',
              prefixIcon:
                  const Icon(Icons.search, color: AppColors.primaryBlue),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (!_isJobs)
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Resale section बघा'),
                  selected: _section == 'resale',
                  onSelected: (_) => setState(() => _section = 'resale'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Rent section'),
                  selected: _section == 'rent',
                  onSelected: (_) => setState(() => _section = 'rent'),
                ),
              ],
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _openPost,
                  icon: const Icon(Icons.add),
                  label: Text(_postLabel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _openMine,
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                ),
                child: const Text('माझ्या पोस्ट'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text('सध्या कोणतीही पोस्ट सापडली नाही',
                    style: TextStyle(color: AppColors.textLight)),
              ),
            )
          else
            ...results.map(_card),
        ],
      ),
    );
  }
}