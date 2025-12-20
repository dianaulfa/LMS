import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(course.name),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: AppColors.accent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Materi'),
              Tab(text: 'Tugas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _MaterialsTab(courseId: course.id),
            _AssignmentsTab(courseId: course.id),
          ],
        ),
      ),
    );
  }
}

class _MaterialsTab extends StatelessWidget {
  final String courseId;

  const _MaterialsTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final materials = MockDatabase.courseMaterials[courseId] ?? [];

    if (materials.isEmpty) {
      return const Center(child: Text('Belum ada materi.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final item = materials[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              item.type == 'Video' ? Icons.play_circle_fill : Icons.description,
              color: AppColors.primary,
              size: 32,
            ),
            title: Text(item.title),
            subtitle: Text('${item.type} • ${item.durationOrPages}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open material logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Membuka ${item.title}...')),
              );
            },
          ),
        );
      },
    );
  }
}

class _AssignmentsTab extends StatelessWidget {
  final String courseId;

  const _AssignmentsTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
     final assignments = MockDatabase.courseAssignments[courseId] ?? [];

    if (assignments.isEmpty) {
      return const Center(child: Text('Belum ada tugas.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final item = assignments[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.assignment, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Tenggat: ${item.deadline}',
                   style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Instruksi: Silakan kerjakan tugas ini sesuai petunjuk lampiran dan kumpulkan dalam format PDF.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur Upload belum tersedia.')),
                      );
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Unggah Pekerjaan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
