import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = MockDatabase.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.notifications, color: AppColors.primary),
            ),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(item.message),
                const SizedBox(height: 4),
                Text(
                  _formatDate(item.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple formatter, in a real app use intl package
    return "${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
