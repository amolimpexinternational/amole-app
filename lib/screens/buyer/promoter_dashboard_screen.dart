import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'promoter_profile_screen.dart';

class _DemoProduct {
  final String name;
  final String seller;
  final int price;
  bool inCatalog = false;

  _DemoProduct(this.name, this.seller, this.price);
}

class PromoterDashboardScreen extends StatefulWidget {
  const PromoterDashboardScreen({super.key});

  @override
  State<PromoterDashboardScreen> createState() =>
      _PromoterDashboardScreenState();
}

class _PromoterDashboardScreenState extends State<PromoterDashboardScreen> {
  static const int _maxCatalog = 50;

  // Dummy data (Demo) — Stage 3 मध्ये Seller ने "प्रमोशन करा" ON केलेली खरी उत्पादने येतील
  final List<_DemoProduct> _products = [
    _DemoProduct('गावरान तूप 500 ml', 'पाटील डेअरी', 450),
    _DemoProduct('मसाला पावडर 1 kg', 'शिंदे मसाले', 320),
    _DemoProduct('हँडलूम साडी', 'जोशी वस्त्र भांडार', 1200),
    _DemoProduct('शेंगदाणा तेल 1 L', 'देशमुख ऑइल मिल', 210),
    _DemoProduct('पापड 500 g', 'सुगरण गृह उद्योग', 150),
    _DemoProduct('मध 250 g', 'वनराई मधुशाळा', 280),
  ];

  String _query = '';

  int get _catalogCount => _products.where((p) => p.inCatalog).length;

  void _addToCatalog(_DemoProduct p) {
    if (_catalogCount >= _maxCatalog) {
      _snack('कॅटलॉग मध्ये जास्तीत जास्त 50 वस्तू जोडता येतात');
      return;
    }
    setState(() => p.inCatalog = true);
    _snack('कॅटलॉग मध्ये जोडले');
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final inCatalog = _products.where((p) => p.inCatalog).toList();
    final notAdded = _products.where((p) => !p.inCatalog).toList();
    final q = _query.trim().toLowerCase();
    final available = q.isEmpty
        ? notAdded
        : notAdded
            .where((p) =>
                p.name.toLowerCase().contains(q) ||
                p.seller.toLowerCase().contains(q))
            .toList();

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Promoter Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.hourglass_top, color: AppColors.primaryOrange),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${PromoterState.name.isEmpty ? 'तुमची' : '${PromoterState.name}, तुमची'} माहिती Franchise कडे verification साठी आहे',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _statBox('माझा कॅटलॉग', '$_catalogCount / $_maxCatalog'),
              ),
              const SizedBox(width: 12),
              Expanded(child: _statBox('मिळालेले कमिशन', '₹0')),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'माझा कॅटलॉग',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                onPressed: () => _snack('WhatsApp share लवकरच येईल'),
                icon: const Icon(Icons.share, size: 18),
                label: const Text('पूर्ण कॅटलॉग शेअर'),
              ),
            ],
          ),
          if (inCatalog.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'कॅटलॉग रिकामा आहे. खालील उत्पादने "कॅटलॉग मध्ये जोडा" करून कॅटलॉग बनवा.',
                style: TextStyle(color: AppColors.textLight, fontSize: 13),
              ),
            )
          else
            _productGrid(
              inCatalog,
              (p) => SizedBox(
                width: double.infinity,
                height: 36,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  onPressed: () => _snack('WhatsApp share लवकरच येईल'),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('शेअर', style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
          const SizedBox(height: 20),
          const Text(
            'प्रमोशनसाठी उपलब्ध उत्पादने',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'किंमत बदलता येत नाही. विक्रीवर 5% कमिशन मिळेल.',
            style: TextStyle(color: AppColors.textLight, fontSize: 12),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'उत्पादन किंवा दुकान शोधा...',
              prefixIcon:
                  const Icon(Icons.search, color: AppColors.primaryBlue),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (available.isEmpty)
            Text(
              notAdded.isEmpty
                  ? 'सर्व उत्पादने कॅटलॉग मध्ये जोडली आहेत.'
                  : 'या शोधासाठी कोणतेही उत्पादन सापडले नाही.',
              style: const TextStyle(
                  color: AppColors.textLight, fontSize: 13),
            )
          else
            _productGrid(
              available,
              (p) => SizedBox(
                width: double.infinity,
                height: 36,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                  ),
                  onPressed: () => _addToCatalog(p),
                  child: const Text(
                    'कॅटलॉग मध्ये जोडा',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Mom's Miracle प्रमाणे 2 रांगांचा grid
  Widget _productGrid(
    List<_DemoProduct> items,
    Widget Function(_DemoProduct) action,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 262,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => _productCard(items[i], action(items[i])),
    );
  }

  Widget _productCard(_DemoProduct p, Widget action) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              color: AppColors.lightGrey,
              child: const Icon(
                Icons.inventory_2,
                size: 54,
                color: AppColors.primaryBlue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    p.seller,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₹${p.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  action,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}