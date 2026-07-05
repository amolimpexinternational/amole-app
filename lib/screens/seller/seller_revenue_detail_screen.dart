import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SellerRevenueDetailScreen extends StatefulWidget {
  const SellerRevenueDetailScreen({super.key});

  @override
  State<SellerRevenueDetailScreen> createState() =>
      _SellerRevenueDetailScreenState();
}

class _SellerRevenueDetailScreenState
    extends State<SellerRevenueDetailScreen> {

  String filter = "Last 30 Days";
  DateTime? selectedDate;
  String selectedDateStr = "";

  Widget summaryCard(
      String title,
      String value,
      IconData icon,
      Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget paymentTile(
      String date,
      String gross,
      bool settled) {
    return Card(
      child: ListTile(
        leading: Icon(
          settled ? Icons.check_circle : Icons.pending,
          color: settled ? Colors.green : Colors.orange,
        ),
        title: Text(date),
        subtitle: Text("विक्री : $gross"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gross,
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            Text(
              settled ? "मिळाले" : "प्रतीक्षेत",
              style: TextStyle(fontSize: 11, color: settled ? Colors.green : Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.lightGrey,

      appBar: AppBar(
        title: const Text("Wallet & Income"),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          DropdownButtonFormField<String>(
            value: filter,
            decoration: const InputDecoration(
              labelText: "Income Period",
            ),
            items: const [
              DropdownMenuItem(
                value: "Last 7 Days",
                child: Text("Last 7 Days"),
              ),
              DropdownMenuItem(
                value: "Last 30 Days",
                child: Text("Last 30 Days"),
              ),
              DropdownMenuItem(
                value: "Custom Date",
                child: Text("Custom Date (Last 3 Years)"),
              ),
            ],
            onChanged: (v) async {
              setState(() { filter = v!; selectedDate = null; selectedDateStr = ""; });
              if (v == "Custom Date") {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 3),
                  lastDate: DateTime.now(),
                  helpText: 'दिवस निवडा',
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                    selectedDateStr = "\${picked.day}/\${picked.month}/\${picked.year}";
                  });
                }
              }
            },
          ),

          const SizedBox(height: 8),

          if (filter == "Custom Date" && selectedDateStr.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.primaryBlue, size: 16),
                  const SizedBox(width: 8),
                  Text("निवडलेला दिवस: \$selectedDateStr",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                ],
              ),
            ),

          const SizedBox(height: 10),
          summaryCard(
            "माझी कमाई",
            "₹52,000",
            Icons.account_balance_wallet,
            Colors.green,
          ),

          const SizedBox(height: 24),

          const Text(
            "Payment History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          paymentTile(
            "04 Jul 2026",
            "₹8,500",
            true,
          ),
          paymentTile(
            "03 Jul 2026",
            "₹12,400",
            true,
          ),
          paymentTile(
            "02 Jul 2026",
            "₹4,800",
            false,
          ),

          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Statement Export झाले!'), backgroundColor: Colors.green),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text("Export Statement"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
