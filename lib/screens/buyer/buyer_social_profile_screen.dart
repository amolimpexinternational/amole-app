import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BuyerSocialProfileScreen extends StatefulWidget {
  const BuyerSocialProfileScreen({super.key});

  @override
  State<BuyerSocialProfileScreen> createState() => _BuyerSocialProfileScreenState();
}

class _BuyerSocialProfileScreenState
    extends State<BuyerSocialProfileScreen> {
  String _profileName = 'राहुल शर्मा';
  String _username = 'rahul.sharma';
  String _bio = 'AMOLE वर आपल्या लोकांशी जोडा आणि स्थानिक बाजाराशी कनेक्ट रहा.';

  final Map<String, String> _profileFields = {
    'शहर / सध्याचे ठिकाण': 'हडपसर, पुणे',
    'मूळ गाव': 'नाशिक',
    'व्यवसाय / प्रोफेशन': 'व्यवसाय',
    'कंपनी / कामाचे ठिकाण': 'Amol Impex International',
    'शिक्षण': 'पदवी',
    'कॉलेज / संस्था': 'Demo College',
    'भाषा': 'मराठी, हिंदी, इंग्रजी',
    'छंद / आवडी': 'प्रवास, क्रिकेट, व्यवसाय',
    'Relationship Status': 'अविवाहित',
    'जन्मतारीख': '15 ऑगस्ट 1995',
    'लिंग': 'पुरुष',
    'मोबाईल': '98XXXXXX10',
    'ई-मेल': 'rahul@example.com',
  };

  final Map<String, bool> _visibility = {
    'शहर / सध्याचे ठिकाण': true,
    'मूळ गाव': false,
    'व्यवसाय / प्रोफेशन': true,
    'कंपनी / कामाचे ठिकाण': false,
    'शिक्षण': true,
    'कॉलेज / संस्था': false,
    'भाषा': true,
    'छंद / आवडी': true,
    'Relationship Status': false,
    'जन्मतारीख': false,
    'लिंग': false,
    'मोबाईल': false,
    'ई-मेल': false,
  };

  void _editText({
    required String title,
    required String initialValue,
    required void Function(String value) onSave,
    int maxLines = 1,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: title,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('रद्द करा'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                onSave(value);
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('जतन करा'),
          ),
        ],
      ),
    );
  }

  void _editField(String field) {
    _editText(
      title: field,
      initialValue: _profileFields[field] ?? '',
      onSave: (value) {
        setState(() {
          _profileFields[field] = value;
        });
      },
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demo Camera option निवडला')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Demo Gallery option निवडला')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Default फोटो'),
              onTap: () {
                Navigator.pop(sheetContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Default फोटो निवडला')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityChip(String field) {
    final isPublic = _visibility[field] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _visibility[field] = !isPublic;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isPublic
              ? AppColors.primaryBlue.withOpacity(0.10)
              : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPublic ? Icons.public : Icons.visibility_off_outlined,
              size: 15,
              color: isPublic
                  ? AppColors.primaryBlue
                  : AppColors.textLight,
            ),
            const SizedBox(width: 4),
            Text(
              isPublic ? 'Public' : 'Hide',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPublic
                    ? AppColors.primaryBlue
                    : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String field, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildVisibilityChip(field),
              const SizedBox(height: 4),
              IconButton(
                onPressed: () => _editField(field),
                icon: const Icon(Icons.edit_outlined, size: 18),
                tooltip: 'Edit',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPublicPreview() {
    final publicFields = _profileFields.entries
        .where((entry) => _visibility[entry.key] == true)
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Public Preview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'इतर लोकांना तुमचे प्रोफाईल असे दिसेल',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.primaryBlue.withOpacity(0.10),
              child: const Icon(
                Icons.person,
                size: 48,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              _profileName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ),
          Center(
            child: Text(
              '@$_username',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textLight,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _bio,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ProfileStat(value: '128', label: 'Friends'),
              _ProfileStat(value: '12', label: 'Posts'),
              _ProfileStat(value: '8', label: 'Mutual'),
            ],
          ),
          if (publicFields.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            ...publicFields.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('माझा सोशल प्रोफाईल'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _showPhotoOptions,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.landscape_outlined,
                        size: 60,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: _showPhotoOptions,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.white,
                  child: const Icon(
                    Icons.person,
                    size: 58,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _profileName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Center(
              child: Text(
                '@$_username',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textLight,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  _editText(
                    title: 'प्रोफाईल नाव',
                    initialValue: _profileName,
                    onSave: (value) {
                      setState(() => _profileName = value);
                    },
                  );
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('नाव बदला'),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  _editText(
                    title: 'Username / Amole ID',
                    initialValue: _username,
                    onSave: (value) {
                      setState(() => _username = value);
                    },
                  );
                },
                icon: const Icon(Icons.alternate_email),
                label: const Text('Username बदला'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _bio,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _editText(
                        title: 'Bio',
                        initialValue: _bio,
                        maxLines: 4,
                        onSave: (value) {
                          setState(() => _bio = value);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildPublicPreview(),
            const SizedBox(height: 24),
            const Text(
              'प्रोफाईल माहिती आणि Privacy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Public केल्यास ही माहिती इतरांना दिसेल. Hide केल्यास ती तुमच्या प्रोफाईलवर दिसणार नाही.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 12),
            ..._profileFields.entries.map(
              (entry) => _buildProfileField(entry.key, entry.value),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'ही Social Profile सुविधा सध्या Demo/Local आहे. तुमची माहिती Firebase किंवा कोणत्याही Backend वर पाठवली जात नाही.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}
