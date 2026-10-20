import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/services_data.dart';
import 'service_requirement_screen.dart';
import 'service_request_status_screen.dart';

class ServicesHomeScreen extends StatefulWidget {
  const ServicesHomeScreen({super.key});

  @override
  State<ServicesHomeScreen> createState() => _ServicesHomeScreenState();
}

class _ServicesHomeScreenState extends State<ServicesHomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // फक्त सशुल्क plan असलेले प्रोव्हायडर, जवळचे आधी
  List<Map<String, dynamic>> get _results {
    final q = _query.trim();
    final list = ServiceData.providers.where((p) {
      if (p['paid'] != true) return false;
      return (p['name'] as String).contains(q) ||
          (p['service'] as String).contains(q);
    }).toList();
    list.sort((a, b) => (a['km'] as double).compareTo(b['km'] as double));
    return list;
  }

  void _openPost({String category = ''}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceRequirementScreen(category: category),
      ),
    ).then((_) => setState(() {}));
  }

  void _pickCategory(String name) {
    setState(() {
      _query = name;
      _searchCtrl.text = name;
    });
  }

  void _showContact(Map<String, dynamic> p) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(p['name'] as String),
        content: Text('${p['service']}\nसंपर्क: ${p['phone']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ठीक आहे'),
          ),
        ],
      ),
    );
  }

  Widget _postCard() {
    return GestureDetector(
      onTap: () => _openPost(category: _query),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.royalBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📝 Post your Requirement',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(
              'तुम्हाला कोणती सेवा हवी ते लिहा. तुमच्या जवळचे प्रोव्हायडर थेट तुमच्याशी संपर्क करतील.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Requirement Post करा',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, color: Colors.white, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryGrid() {
    final cats = ServiceData.categories;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 92,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: cats.length,
      itemBuilder: (context, i) {
        final c = cats[i];
        return GestureDetector(
          onTap: () => _pickCategory(c['name'] as String),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(c['icon'] as IconData,
                    color: AppColors.primaryBlue, size: 30),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    c['name'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _providerCard(Map<String, dynamic> p) {
    return Container(
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
            child: const Icon(Icons.handyman_outlined,
                color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] as String,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark)),
                const SizedBox(height: 2),
                Text('${p['service']} · ${p['km']} km',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textLight)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text(p['rating'] as String,
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _showContact(p),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 40),
            ),
            child: const Text('संपर्क'),
          ),
        ],
      ),
    );
  }

  Widget _myPosts() {
    final posts = ServiceRequests.posted;
    if (posts.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('माझ्या Requirements',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark)),
        const SizedBox(height: 8),
        ...posts.map((r) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceRequestStatusScreen(request: r),
                ),
              ).then((_) => setState(() {})),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '#${r['id']} · ${r['category'] == '' ? 'सेवा' : r['category']} · ${r['location']}',
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textDark),
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textLight),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final searching = _query.trim().isNotEmpty;
    final results = _results;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('🛠️ Services & Repair',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'तुम्हाला हवी ती सेवा शोधा...',
              prefixIcon:
                  const Icon(Icons.search, color: AppColors.primaryBlue),
              suffixIcon: searching
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() {
                        _query = '';
                        _searchCtrl.clear();
                      }),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _postCard(),
          const SizedBox(height: 16),
          if (!searching) ...[
            const Text('सर्व सेवा',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 8),
            _categoryGrid(),
            _myPosts(),
          ] else ...[
            Text('"$_query" साठी प्रोव्हायडर',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 4),
            const Text('फक्त सशुल्क plan असलेले प्रोव्हायडर दिसतात.',
                style: TextStyle(fontSize: 11, color: AppColors.textLight)),
            const SizedBox(height: 10),
            if (results.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'सध्या कोणी प्रोव्हायडर सापडला नाही. वर Requirement Post करा.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textLight),
                  ),
                ),
              )
            else
              ...results.map(_providerCard),
          ],
        ],
      ),
    );
  }
}