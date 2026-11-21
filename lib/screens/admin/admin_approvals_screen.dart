
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AdminApprovalsScreen extends StatefulWidget {
  const AdminApprovalsScreen({super.key});

  @override
  State<AdminApprovalsScreen> createState() =>
      _AdminApprovalsScreenState();
}

class _AdminApprovalsScreenState extends State<AdminApprovalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // DEMO DATA: Pending Ads
  final List<Map<String, dynamic>> _adGroups = [
    {
      'cp': 'पुणे CP',
      'phone': '+91 9876543210',
      'franchises': [
        {
          'franchise': 'हडपसर फ्रँचाइजी',
          'phone': '+91 9876543211',
          'items': [
            {
              'title': 'पाटील किराणा स्टोअर — Photo Ad',
              'sender': 'पाटील किराणा स्टोअर',
              'senderPhone': '+91 9988776655',
              'senderType': 'Seller',
              'days': '3 दिवसांपूर्वी',
              'budget': '₹300',
              'status': 'pending',
            },
            {
              'title': 'जोशी किराणा — Text Ad',
              'sender': 'जोशी किराणा',
              'senderPhone': '+91 9988776656',
              'senderType': 'Seller',
              'days': '2 दिवसांपूर्वी',
              'budget': '₹200',
              'status': 'pending',
            },
          ],
        },
        {
          'franchise': 'कोथरूड फ्रँचाइजी',
          'phone': '+91 9876543212',
          'items': [
            {
              'title': 'श्री साई मेडिकल — Text Ad',
              'sender': 'श्री साई मेडिकल',
              'senderPhone': '+91 9988776657',
              'senderType': 'Seller',
              'days': '1 दिवसापूर्वी',
              'budget': '₹150',
              'status': 'pending',
            },
          ],
        },
      ],
    },
    {
      'cp': 'नागपूर CP',
      'phone': '+91 9876543213',
      'franchises': [
        {
          'franchise': 'नागपूर फ्रँचाइजी',
          'phone': '+91 9876543214',
          'items': [
            {
              'title': 'नागपूर किराणा — Video Ad',
              'sender': 'नागपूर किराणा',
              'senderPhone': '+91 9988776659',
              'senderType': 'Seller',
              'days': '5 दिवसांपूर्वी',
              'budget': '₹500',
              'status': 'pending',
            },
          ],
        },
      ],
    },
  ];

  // DEMO DATA: Pending Offers
  final List<Map<String, dynamic>> _offerGroups = [
    {
      'cp': 'पुणे CP',
      'phone': '+91 9876543210',
      'franchises': [
        {
          'franchise': 'हडपसर फ्रँचाइजी',
          'phone': '+91 9876543211',
          'items': [
            {
              'title': 'पाटील किराणा — 10% Discount Offer',
              'sender': 'पाटील किराणा स्टोअर',
              'senderPhone': '+91 9988776655',
              'senderType': 'Seller',
              'days': '1 दिवसापूर्वी',
              'budget': '₹500',
              'status': 'pending',
            },
            {
              'title': 'जोशी किराणा — Buy 1 Get 1',
              'sender': 'जोशी किराणा',
              'senderPhone': '+91 9988776656',
              'senderType': 'Seller',
              'days': '2 दिवसांपूर्वी',
              'budget': '₹250',
              'status': 'pending',
            },
          ],
        },
        {
          'franchise': 'कोथरूड फ्रँचाइजी',
          'phone': '+91 9876543212',
          'items': [
            {
              'title': 'श्री साई मेडिकल — Special Offer',
              'sender': 'श्री साई मेडिकल',
              'senderPhone': '+91 9988776657',
              'senderType': 'Seller',
              'days': '3 दिवसांपूर्वी',
              'budget': '₹300',
              'status': 'pending',
            },
          ],
        },
      ],
    },
  ];

  // DEMO DATA: Pending Onboarding
  final List<Map<String, dynamic>> _onboardingGroups = [
    {
      'cp': 'पुणे CP',
      'phone': '+91 9876543210',
      'franchises': [
        {
          'franchise': 'हडपसर फ्रँचाइजी',
          'phone': '+91 9876543211',
          'items': [
            {
              'title': 'न्यू फॅशन पॉईंट',
              'senderType': 'Seller',
              'senderPhone': '+91 9988776655',
              'days': '1 दिवसापूर्वी',
              'status': 'pending',
            },
            {
              'title': 'जोशी किराणा',
              'senderType': 'Seller',
              'senderPhone': '+91 9988776656',
              'days': '2 दिवसांपूर्वी',
              'status': 'pending',
            },
          ],
        },
        {
          'franchise': 'कोथरूड फ्रँचाइजी',
          'phone': '+91 9876543212',
          'items': [
            {
              'title': 'श्री साई मेडिकल',
              'senderType': 'Seller',
              'senderPhone': '+91 9988776657',
              'days': '4 दिवसांपूर्वी',
              'status': 'pending',
            },
            {
              'title': 'वडगाव फ्रँचाइजी',
              'senderType': 'Franchise',
              'senderPhone': '+91 9988776660',
              'days': '10 दिवसांपूर्वी',
              'status': 'pending',
            },
          ],
        },
      ],
    },
    {
      'cp': 'नागपूर CP',
      'phone': '+91 9876543213',
      'franchises': [
        {
          'franchise': 'नागपूर फ्रँचाइजी',
          'phone': '+91 9876543214',
          'items': [
            {
              'title': 'नागपूर नवीन Seller',
              'senderType': 'Seller',
              'senderPhone': '+91 9988776661',
              'days': '3 दिवसांपूर्वी',
              'status': 'pending',
            },
          ],
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _countPending(List<Map<String, dynamic>> groups) {
    int count = 0;

    for (final cp in groups) {
      for (final franchise in cp['franchises']) {
        for (final item in franchise['items']) {
          if (item['status'] == 'pending') {
            count++;
          }
        }
      }
    }

    return count;
  }

  void _updateStatus(Map<String, dynamic> item, String status) {
    setState(() {
      item['status'] = status;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == 'approved'
              ? 'विनंती मंजूर केली आहे.'
              : 'विनंती नाकारली आहे.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Seller':
        return Colors.teal;
      case 'Franchise':
        return AppColors.primaryBlue;
      case 'Channel Partner':
        return Colors.purple;
      case 'Promoter':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Pending Approvals (Admin)'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabs: [
            Tab(text: 'Ads (${_countPending(_adGroups)})'),
            Tab(text: 'Offers (${_countPending(_offerGroups)})'),
            Tab(
              text: 'Onboarding (${_countPending(_onboardingGroups)})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGroupedTab(
            _adGroups,
            title: 'जाहिराती',
            isOnboarding: false,
          ),
          _buildGroupedTab(
            _offerGroups,
            title: 'Offers',
            isOnboarding: false,
          ),
          _buildGroupedTab(
            _onboardingGroups,
            title: 'Onboarding विनंत्या',
            isOnboarding: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedTab(
    List<Map<String, dynamic>> groups, {
    required String title,
    required bool isOnboarding,
  }) {
    final pendingCount = _countPending(groups);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: isOnboarding
                ? Colors.blue.shade50
                : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isOnboarding
                  ? Colors.blue.shade200
                  : Colors.orange.shade200,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isOnboarding
                    ? Icons.person_add_alt_1
                    : Icons.pending_actions,
                color: isOnboarding
                    ? Colors.blue.shade700
                    : Colors.orange.shade700,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'एकूण $pendingCount $title प्रतीक्षेत',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isOnboarding
                            ? Colors.blue.shade900
                            : Colors.orange.shade900,
                      ),
                    ),
                    Text(
                      '${groups.length} Channel Partners अंतर्गत',
                      style: TextStyle(
                        fontSize: 12,
                        color: isOnboarding
                            ? Colors.blue.shade700
                            : Colors.orange.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (pendingCount == 0)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 55,
                  color: Colors.green,
                ),
                SizedBox(height: 12),
                Text(
                  'सध्या कोणतीही Pending विनंती नाही.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),

        ...groups.map((cp) {
          final franchises =
              cp['franchises'] as List<Map<String, dynamic>>;

          int cpPending = 0;

          for (final franchise in franchises) {
            for (final item
                in franchise['items'] as List<Map<String, dynamic>>) {
              if (item['status'] == 'pending') {
                cpPending++;
              }
            }
          }

          if (cpPending == 0) {
            return const SizedBox.shrink();
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.purple.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.hub,
                        color: Colors.purple.shade700,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cp['cp'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: AppColors.textDark,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: AppColors.primaryBlue,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  cp['phone'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$cpPending Pending',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ...franchises.map((franchise) {
                  final items =
                      franchise['items'] as List<Map<String, dynamic>>;

                  final pendingItems = items
                      .where((item) => item['status'] == 'pending')
                      .toList();

                  if (pendingItems.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        color: AppColors.lightGrey.withValues(alpha: 0.5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.business,
                              size: 16,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                franchise['franchise'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.phone,
                              size: 12,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              franchise['phone'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ...pendingItems.map(
                        (item) => _buildRequestCard(
                          item,
                          isOnboarding: isOnboarding,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRequestCard(
    Map<String, dynamic> item, {
    required bool isOnboarding,
  }) {
    final type = item['senderType'] as String;
    final typeColor = _typeColor(type);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: typeColor.withValues(alpha: 0.1),
                child: Icon(
                  isOnboarding
                      ? (type == 'Franchise'
                          ? Icons.business
                          : Icons.store_outlined)
                      : (type == 'Seller'
                          ? Icons.campaign_outlined
                          : Icons.local_offer_outlined),
                  color: typeColor,
                  size: 17,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      isOnboarding
                          ? '$type • ${item['days']}'
                          : '${item['sender']} ($type)',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.phone, size: 14, color: typeColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'संपर्क: ${item['senderPhone']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: typeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          if (!isOnboarding)
            Text(
              '${item['days']} • बजेट ${item['budget']}',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textLight,
              ),
            ),

          if (isOnboarding)
            Text(
              'नोंदणी विनंती: ${item['days']}',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textLight,
              ),
            ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.errorRed,
                    side: const BorderSide(
                      color: AppColors.errorRed,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 7),
                  ),
                  onPressed: () {
                    _updateStatus(item, 'rejected');
                  },
                  child: const Text(
                    'नाकारा',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successGreen,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                  ),
                  onPressed: () {
                    _updateStatus(item, 'approved');
                  },
                  child: const Text(
                    'मंजूर करा',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
