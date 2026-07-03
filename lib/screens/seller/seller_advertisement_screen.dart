import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerAdvertisementScreen extends StatefulWidget {
  const SellerAdvertisementScreen({super.key});

  @override
  State<SellerAdvertisementScreen> createState() => _SellerAdvertisementScreenState();
}

class _SellerAdvertisementScreenState extends State<SellerAdvertisementScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  int _selectedDays = 7;
  bool _imageSelected = false;

  final List<int> _durationOptions = [3, 7, 15, 30];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _pickImage() {
    setState(() {
      _imageSelected = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('फोटो निवडला (demo) — खरं upload पुढे Firebase सोबत जोडलं जाईल'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _submitAd() {
    if (!_imageSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया आधी जाहिरातीसाठी फोटो निवडा'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: AppColors.successGreen, size: 28),
              SizedBox(width: 10),
              Text('जाहिरात पाठवली!'),
            ],
          ),
          content: const Text(
            'तुमची जाहिरात Franchise कडे approval साठी पाठवली आहे. मंजूर झाल्यावर ती दिसायला सुरुवात होईल.',
            style: TextStyle(color: AppColors.textDark),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('ठीक आहे'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 20),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
      ),
    );
  }

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        title: const Text('जाहिरात तयार करा'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, color: AppColors.primaryOrange, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'जाहिरात Franchise कडून approve झाल्यावरच Buyers ना दिसेल',
                          style: TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildLabel('जाहिरातीचा फोटो / बॅनर'),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _imageSelected ? AppColors.successGreen : AppColors.textLight,
                        width: _imageSelected ? 2 : 1,
                      ),
                    ),
                    child: _imageSelected
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle, color: AppColors.successGreen, size: 36),
                              SizedBox(height: 8),
                              Text('फोटो निवडला ✓', style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_photo_alternate_outlined, color: AppColors.textLight, size: 36),
                              SizedBox(height: 8),
                              Text('फोटो निवडण्यासाठी टॅप करा', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
                            ],
                          ),
                  ),
                ),
                _buildLabel('जाहिरातीचं शीर्षक'),
                TextFormField(
                  controller: _titleController,
                  decoration: _inputStyle('उदा. होळी स्पेशल ऑफर — 20% सूट'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'शीर्षक टाकणं आवश्यक आहे';
                    }
                    return null;
                  },
                ),
                _buildLabel('वर्णन'),
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: _inputStyle('जाहिरातीबद्दल थोडक्यात माहिती लिहा...'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'वर्णन टाकणं आवश्यक आहे';
                    }
                    return null;
                  },
                ),
                _buildLabel('जाहिरात किती दिवस चालवायची?'),
                Wrap(
                  spacing: 10,
                  children: _durationOptions.map((days) {
                    final isSelected = _selectedDays == days;
                    return ChoiceChip(
                      label: Text('$days दिवस'),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedDays = days),
                      selectedColor: AppColors.primaryBlue,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitAd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('जाहिरात पाठवा', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
