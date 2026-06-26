import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class StockManagementScreen extends StatelessWidget {
  const StockManagementScreen({super.key});

  Widget stockItem(String name, String stock) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.inventory_2_outlined),
        title: Text(name),
        subtitle: Text('Available Stock: $stock'),
        trailing: const Icon(Icons.edit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        title: const Text('Stock Management'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          stockItem('Organic Mango', '120 Kg'),
          stockItem('Fresh Tomato', '80 Kg'),
          stockItem('Natural Honey', '45 Bottles'),
          stockItem('Green Chilli', '60 Kg'),
        ],
      ),
    );
  }
}
