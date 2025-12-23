import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart';

class JoinClassScreen extends StatefulWidget {
  final User user;
  const JoinClassScreen({super.key, required this.user});

  @override
  State<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  final _codeController = TextEditingController();
  String? _errorMessage;

  void _joinClass() {
    setState(() => _errorMessage = null);
    
    if (_codeController.text.isEmpty) {
       setState(() => _errorMessage = 'Masukkan kode kelas');
       return;
    }

    final success = MockDatabase.joinCourse(_codeController.text.trim(), widget.user.email);
    
    if (success) {
      Navigator.pop(context, true);
    } else {
      setState(() => _errorMessage = 'Kode kelas tidak valid atau Anda sudah bergabung');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gabung ke Kelas'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
         actions: [
          TextButton(
            onPressed: _joinClass,
            child: const Text('Gabung', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mintalah kode kelas kepada pengajar Anda, lalu masukkan kode di sini.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Kode Kelas',
                hintText: 'Contoh: X7Z9A2',
                border: const OutlineInputBorder(),
                errorText: _errorMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
