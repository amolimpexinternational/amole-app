import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

enum OfferKind { percentDiscount, buyXGetY, minPurchaseFlatOff, firstPurchaseGift, custom }

class SpecialOffer {
  final String id;
  final OfferKind kind;
  final String title;
  final String description;
  final int validityDays;
  bool active;
  SpecialOffer({
    required this.id,
    required this.kind,
    required this.title,
    required this.description,
    required this.validityDays,
    this.active = true,
  });
}

IconData offerIcon(OfferKind k) {
  switch (k) {
    case OfferKind.percentDiscount: return Icons.percent;
    case OfferKind.buyXGetY: return Icons.card_giftcard_outlined;
    case OfferKind.minPurchaseFlatOff: return Icons.local_offer_outlined;
    case OfferKind.firstPurchaseGift: return Icons.redeem_outlined;
    case OfferKind.custom: return Icons.auto_awesome_outlined;
  }
}

Color offerColor(OfferKind k) {
  switch (k) {
    case OfferKind.percentDiscount: return AppColors.successGreen;
    case OfferKind.buyXGetY: return AppColors.primaryOrange;
    case OfferKind.minPurchaseFlatOff: return AppColors.primaryBlue;
    case OfferKind.firstPurchaseGift: return Colors.purple;
    case OfferKind.custom: return Colors.teal;
  }
}

String offerKindLabel(OfferKind k) {
  switch (k) {
    case OfferKind.percentDiscount: return 'MRP वर सूट';
    case OfferKind.buyXGetY: return 'Buy X Get Y Free';
    case OfferKind.minPurchaseFlatOff: return 'ठराविक खरेदीवर फ्लॅट सूट';
    case OfferKind.firstPurchaseGift: return 'पहिल्या खरेदीवर बक्षीस';
    case OfferKind.custom: return 'Custom / Creative ऑफर';
  }
}

class SellerDiscountOfferScreen extends StatefulWidget {
  const SellerDiscountOfferScreen({super.key});

  @override
  State<SellerDiscountOfferScreen> createState() => _SellerDiscountOfferScreenState();
}

class _SellerDiscountOfferScreenState extends State<SellerDiscountOfferScreen> {
  // TODO (Stage 3 - Backend): replace with Firestore collection 'seller_offers'
  final List<SpecialOffer> _offers = [];

  void _openAddOfferSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _AddOfferSheet(onCreate: (offer) {
        setState(() => _offers.insert(0, offer));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ नवीन Special Offer तयार झाला'), backgroundColor: Colors.green),
        );
      }),
    );
  }

  void _toggleActive(SpecialOffer o) => setState(() => o.active = !o.active);

  void _deleteOffer(SpecialOffer o) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ऑफर काढायची का?'),
        content: Text(o.title),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करा')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              setState(() => _offers.remove(o));
              Navigator.pop(ctx);
            },
            child: const Text('काढा', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('स्पेशल ऑफर्स'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _offers.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_offer_outlined, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    const Text('अजून कोणतीही Special Offer तयार केलेली नाही', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Text('"+" बटण दाबून तुमची पहिली creative ऑफर तयार करा — सूट, Buy1Get1, गिफ्ट, किंवा तुमची स्वतःची कल्पना!', style: TextStyle(fontSize: 13, color: AppColors.textLight), textAlign: TextAlign.center),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _offers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final o = _offers[i];
                final color = offerColor(o.kind);
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: o.active ? color.withValues(alpha: 0.3) : Colors.grey.shade200),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                          child: Icon(offerIcon(o.kind), color: color, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(o.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
                            Text(offerKindLabel(o.kind), style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                        Switch(
                          value: o.active,
                          activeColor: AppColors.successGreen,
                          onChanged: (_) => _toggleActive(o),
                        ),
                      ]),
                      if (o.description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(o.description, style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
                      ],
                      const SizedBox(height: 8),
                      Row(children: [
                        Icon(Icons.access_time, size: 13, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text('${o.validityDays} दिवसांसाठी वैध', style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => _deleteOffer(o),
                          icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.errorRed),
                          label: const Text('काढा', style: TextStyle(color: AppColors.errorRed, fontSize: 12)),
                        ),
                      ]),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: _openAddOfferSheet,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('नवीन ऑफर', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _AddOfferSheet extends StatefulWidget {
  final void Function(SpecialOffer) onCreate;
  const _AddOfferSheet({required this.onCreate});

  @override
  State<_AddOfferSheet> createState() => _AddOfferSheetState();
}

class _AddOfferSheetState extends State<_AddOfferSheet> {
  OfferKind _kind = OfferKind.percentDiscount;
  int _validityDays = 7;

  // % सूट
  final _mrpCtrl = TextEditingController(text: '100');
  final _priceCtrl = TextEditingController(text: '90');

  // Buy X Get Y
  final _buyQtyCtrl = TextEditingController(text: '1');
  final _getQtyCtrl = TextEditingController(text: '1');

  // ठराविक खरेदीवर सूट
  final _minPurchaseCtrl = TextEditingController(text: '1000');
  final _flatOffCtrl = TextEditingController(text: '50');

  // पहिल्या खरेदीवर बक्षीस
  final _giftCtrl = TextEditingController(text: 'मोफत भेटवस्तू');

  // Custom
  final _customTitleCtrl = TextEditingController();
  final _customDescCtrl = TextEditingController();

  double get _mrp => double.tryParse(_mrpCtrl.text) ?? 0;
  double get _price => double.tryParse(_priceCtrl.text) ?? 0;
  double get _discountPct => _mrp > 0 ? ((_mrp - _price) / _mrp * 100) : 0;

  String get _previewTitle {
    switch (_kind) {
      case OfferKind.percentDiscount:
        return '${_discountPct.toStringAsFixed(0)}% सूट';
      case OfferKind.buyXGetY:
        return 'Buy ${_buyQtyCtrl.text} Get ${_getQtyCtrl.text} Free';
      case OfferKind.minPurchaseFlatOff:
        return '₹${_minPurchaseCtrl.text} च्या खरेदीवर ₹${_flatOffCtrl.text} सूट';
      case OfferKind.firstPurchaseGift:
        return 'पहिल्या खरेदीवर हमखास बक्षीस';
      case OfferKind.custom:
        return _customTitleCtrl.text.isEmpty ? 'तुमची Custom ऑफर' : _customTitleCtrl.text;
    }
  }

  String get _previewDesc {
    switch (_kind) {
      case OfferKind.percentDiscount:
        return 'MRP ₹${_mrpCtrl.text} → आता ₹${_priceCtrl.text} मध्ये';
      case OfferKind.buyXGetY:
        return '${_buyQtyCtrl.text} वस्तू खरेदी करा, ${_getQtyCtrl.text} मोफत मिळवा';
      case OfferKind.minPurchaseFlatOff:
        return 'किमान ₹${_minPurchaseCtrl.text} ची खरेदी केल्यास ₹${_flatOffCtrl.text} सूट मिळेल';
      case OfferKind.firstPurchaseGift:
        return _giftCtrl.text;
      case OfferKind.custom:
        return _customDescCtrl.text;
    }
  }

  bool get _isValid {
    switch (_kind) {
      case OfferKind.percentDiscount:
        return _mrp > 0 && _price >= 0 && _price <= _mrp;
      case OfferKind.buyXGetY:
        return (int.tryParse(_buyQtyCtrl.text) ?? 0) > 0 && (int.tryParse(_getQtyCtrl.text) ?? 0) > 0;
      case OfferKind.minPurchaseFlatOff:
        return (double.tryParse(_minPurchaseCtrl.text) ?? 0) > 0 && (double.tryParse(_flatOffCtrl.text) ?? 0) > 0;
      case OfferKind.firstPurchaseGift:
        return _giftCtrl.text.trim().isNotEmpty;
      case OfferKind.custom:
        return _customTitleCtrl.text.trim().isNotEmpty;
    }
  }

  void _save() {
    if (!_isValid) return;
    widget.onCreate(SpecialOffer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      kind: _kind,
      title: _previewTitle,
      description: _previewDesc,
      validityDays: _validityDays,
    ));
    Navigator.pop(context);
  }

  Widget _chip(OfferKind k) {
    final selected = _kind == k;
    final color = offerColor(k);
    return ChoiceChip(
      label: Text(offerKindLabel(k), style: TextStyle(fontSize: 12, color: selected ? Colors.white : AppColors.textDark)),
      avatar: Icon(offerIcon(k), size: 16, color: selected ? Colors.white : color),
      selected: selected,
      selectedColor: color,
      backgroundColor: color.withValues(alpha: 0.08),
      onSelected: (_) => setState(() => _kind = k),
    );
  }

  Widget _field(TextEditingController c, String label, {bool isNumber = true, int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines ?? 1,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), filled: true, fillColor: AppColors.lightGrey),
      ),
    );
  }

  Widget _kindFields() {
    switch (_kind) {
      case OfferKind.percentDiscount:
        return Column(children: [
          _field(_mrpCtrl, 'MRP (₹)'),
          _field(_priceCtrl, 'तुमची किंमत (₹)'),
        ]);
      case OfferKind.buyXGetY:
        return Row(children: [
          Expanded(child: _field(_buyQtyCtrl, 'किती खरेदी (Buy)')),
          const SizedBox(width: 10),
          Expanded(child: _field(_getQtyCtrl, 'किती मोफत (Get Free)')),
        ]);
      case OfferKind.minPurchaseFlatOff:
        return Column(children: [
          _field(_minPurchaseCtrl, 'किमान खरेदी रक्कम (₹)'),
          _field(_flatOffCtrl, 'मिळणारी सूट (₹)'),
        ]);
      case OfferKind.firstPurchaseGift:
        return _field(_giftCtrl, 'बक्षीस काय असेल?', isNumber: false);
      case OfferKind.custom:
        return Column(children: [
          _field(_customTitleCtrl, 'ऑफरचं शीर्षक (तुमच्या शब्दांत)', isNumber: false),
          _field(_customDescCtrl, 'तपशील (ऐच्छिक)', isNumber: false, maxLines: 3),
        ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('नवीन Special Offer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ]),
            const SizedBox(height: 6),
            const Text('ऑफरचा प्रकार निवडा — किंवा Custom निवडून स्वतःची creative ऑफर लिहा', style: TextStyle(fontSize: 12, color: AppColors.textLight)),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: OfferKind.values.map(_chip).toList()),
            const SizedBox(height: 16),
            _kindFields(),
            const SizedBox(height: 4),
            Text('वैधता: $_validityDays दिवस', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
            Slider(
              value: _validityDays.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              activeColor: AppColors.primaryBlue,
              label: '$_validityDays',
              onChanged: (v) => setState(() => _validityDays = v.round()),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: offerColor(_kind).withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: offerColor(_kind).withValues(alpha: 0.25))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.visibility_outlined, size: 16, color: offerColor(_kind)),
                  const SizedBox(width: 6),
                  Text('असं दिसेल ग्राहकाला:', style: TextStyle(fontSize: 11, color: offerColor(_kind), fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 6),
                Text(_previewTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                if (_previewDesc.isNotEmpty) Text(_previewDesc, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isValid ? _save : null,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('ऑफर Save करा', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
