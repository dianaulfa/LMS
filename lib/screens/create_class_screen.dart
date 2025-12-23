import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart';

class CreateClassScreen extends StatefulWidget {
  final User user;
  const CreateClassScreen({super.key, required this.user});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _nameController = TextEditingController();
  final _sectionController = TextEditingController();
  final _roomController = TextEditingController();
  final _subjectController = TextEditingController();

  void _createClass() {
    if (_nameController.text.isEmpty) return;

    MockDatabase.createCourse(
      _nameController.text,
      _sectionController.text,
      _roomController.text,
      _subjectController.text,
      widget.user.email,
    );

    Navigator.pop(context, true); // Return true to indicate success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Kelas'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _createClass,
            child: const Text('Buat', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Kelas (wajib)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _sectionController,
              decoration: const InputDecoration(
                labelText: 'Bagian',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _roomController,
              decoration: const InputDecoration(
                labelText: 'Ruang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Mata Pelajaran',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
