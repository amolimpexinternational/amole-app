import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  State<SellerRegistrationScreen> createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState
    extends State<SellerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _keywordsController = TextEditingController();
  final _businessContactController = TextEditingController();

  String? _selectedCategory;
  File? _businessImage;

  final List<String> _categories = [
    'Grocery',
    'Agriculture',
    'Clothing',
    'Electronics',
    'Food & Restaurant',
    'Beauty & Personal Care',
    'Hardware',
    'Medical',
    'Services',
    'Other',
  ];

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _pinCodeController.dispose();
    _keywordsController.dispose();
    _businessContactController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if (image == null) return;

    setState(() {
      _businessImage = File(image.path);
    });
  }

  void _showImageOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_businessImage != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('Remove Photo'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    setState(() {
                      _businessImage = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _mobileValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile Number is required';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 10) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final email = value.trim();

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _pinCodeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pin Code is required';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'Enter a valid 6-digit Pin Code';
    }

    return null;
  }

  String? _businessContactValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Contact Number is required';
    }

    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 10) {
      return 'Enter a valid 10-digit contact number';
    }

    return null;
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a Business Category'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Step 1 completed. Next registration step will be connected here.',
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primaryBlue,
          width: 2,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Seller Registration'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Step 1 of Seller Registration',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Basic Business Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Enter your business details to create your Seller profile.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),

              // Business / Shop photo
              Center(
                child: GestureDetector(
                  onTap: _showImageOptions,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.white,
                        backgroundImage: _businessImage != null
                            ? FileImage(_businessImage!)
                            : null,
                        child: _businessImage == null
                            ? const Icon(
                                Icons.storefront_outlined,
                                size: 54,
                                color: AppColors.primaryBlue,
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Add Shop / Business Logo Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _businessNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  label: 'Business Name',
                  icon: Icons.business_outlined,
                  hint: 'Enter your business name',
                ),
                validator: (value) =>
                    _requiredValidator(value, 'Business Name'),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _ownerNameController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  label: 'Owner Name',
                  icon: Icons.person_outline,
                  hint: 'Enter owner name',
                ),
                validator: (value) =>
                    _requiredValidator(value, 'Owner Name'),
              ),
              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: _inputDecoration(
                  label: 'Business Category',
                  icon: Icons.category_outlined,
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Business Category is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: _inputDecoration(
                  label: 'Mobile Number',
                  icon: Icons.phone_android_outlined,
                  hint: '10-digit mobile number',
                ).copyWith(counterText: ''),
                validator: _mobileValidator,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  label: 'Email',
                  icon: Icons.email_outlined,
                  hint: 'example@email.com',
                ),
                validator: _emailValidator,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _cityController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  label: 'Village / City',
                  icon: Icons.location_city_outlined,
                  hint: 'Enter village or city',
                ),
                validator: (value) =>
                    _requiredValidator(value, 'Village / City'),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _pinCodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: _inputDecoration(
                  label: 'Pin Code',
                  icon: Icons.pin_drop_outlined,
                  hint: '6-digit Pin Code',
                ).copyWith(counterText: ''),
                validator: _pinCodeValidator,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _addressController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: _inputDecoration(
                  label: 'Business Address',
                  icon: Icons.location_on_outlined,
                  hint: 'Enter complete business address',
                ),
                validator: (value) =>
                    _requiredValidator(value, 'Business Address'),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _keywordsController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: _inputDecoration(
                  label: 'Search Keywords',
                  icon: Icons.search_outlined,
                  hint:
                      'Example: grocery, farmer store, seeds, agriculture',
                ),
                validator: (value) =>
                    _requiredValidator(value, 'Search Keywords'),
              ),
              const SizedBox(height: 6),
              Text(
                'Add words customers may use to find your business or products.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _businessContactController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: _inputDecoration(
                  label: 'Business Contact Number',
                  icon: Icons.contact_phone_outlined,
                  hint: 'Number visible to customers',
                ).copyWith(counterText: ''),
                validator: _businessContactValidator,
              ),
              const SizedBox(height: 4),
              Text(
                'This number will be displayed to customers on your business profile.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
