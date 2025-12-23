import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart'; // User class is here

import 'create_class_screen.dart';
import 'join_class_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // final user = MockDatabase.currentUser; // Removed static reference

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // ... existing body code ...
        child: Column(
          children: [
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.avatarUrl),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About Me',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.calendar_today, 'Semester', user.semester),
                      const Divider(),
                      _buildInfoRow(Icons.class_, 'Kelas', user.studentClass),
                      const Divider(),
                       _buildInfoRow(Icons.school, 'Status', 'Mahasiswa Aktif'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActionMenu(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.add_circle_outline, color: AppColors.primary),
              title: const Text('Buat Kelas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateClassScreen(user: user)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sensor_door, color: AppColors.primary),
              title: const Text('Gabung ke Kelas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinClassScreen(user: user)),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
// ... existing _buildInfoRow implementation ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
