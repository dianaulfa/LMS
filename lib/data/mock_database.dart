import 'dart:async';

class User {
  final String name;
  final String email;
  final String semester;
  final String studentClass;
  final String avatarUrl;

  User({
    required this.name,
    required this.email,
    required this.semester,
    required this.studentClass,
    required this.avatarUrl,
  });
}

class Course {
  final String id;
  final String name;
  final String code;
  final double progress; // 0.0 to 1.0
  final String semester;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.progress,
    required this.semester,
  });
}

class MaterialItem {
  final String id;
  final String title;
  final String type; // 'Video', 'Module'
  final String durationOrPages;

  MaterialItem({
    required this.id,
    required this.title,
    required this.type,
    required this.durationOrPages,
  });
}

class Assignment {
  final String id;
  final String title;
  final String deadline;
  final bool isSubmitted;

  Assignment({
    required this.id,
    required this.title,
    required this.deadline,
    this.isSubmitted = false,
  });
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

class MockDatabase {
  static final User currentUser = User(
    name: 'Mahasiswa Teladan',
    email: 'mahasiswa@university.ac.id',
    semester: '7',
    studentClass: 'A',
    avatarUrl: 'https://i.pravatar.cc/150?img=3',
  );

  static final List<Course> courses = [
    Course(id: 'c1', name: 'Programming Lanjut', code: 'PROG701', progress: 0.75, semester: '7'),
    Course(id: 'c2', name: 'Cybersecurity', code: 'SEC702', progress: 0.40, semester: '7'),
    Course(id: 'c3', name: 'Sistem Info Geografis', code: 'SIG703', progress: 0.20, semester: '7'),
    Course(id: 'c4', name: 'Sistem Cerdas', code: 'AI704', progress: 0.10, semester: '7'),
  ];

  static final Map<String, List<MaterialItem>> courseMaterials = {
    'c1': [
      MaterialItem(id: 'm1', title: 'Pengenalan Flutter', type: 'Video', durationOrPages: '15:00'),
      MaterialItem(id: 'm2', title: 'State Management', type: 'Modul', durationOrPages: '12 Halaman'),
    ],
    'c2': [
      MaterialItem(id: 'm3', title: 'Network Security Basics', type: 'Video', durationOrPages: '45:00'),
    ],
    'c3': [
      MaterialItem(id: 'm4', title: 'Intro to GIS', type: 'Modul', durationOrPages: '20 Halaman'),
    ],
    'c4': [
      MaterialItem(id: 'm5', title: 'Neural Networks', type: 'Video', durationOrPages: '30:00'),
    ],
  };

  static final Map<String, List<Assignment>> courseAssignments = {
    'c1': [
      Assignment(id: 'a1', title: 'Buat UI Aplikasi LMS', deadline: '25 Des 2024'),
    ],
    'c2': [
      Assignment(id: 'a2', title: 'Analisis Packet Tracer', deadline: '28 Des 2024'),
    ],
    'c3': [],
    'c4': [
       Assignment(id: 'a3', title: 'Implementasi Perceptron', deadline: '30 Des 2024'),
    ],
  };
  
  static final List<NotificationItem> notifications = [
    NotificationItem(
      id: 'n1',
      title: 'Tugas Baru: Programming Lanjut',
      message: 'Dosen telah menambahkan tugas baru "Buat UI Aplikasi LMS".',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      id: 'n2',
      title: 'Jadwal Ujian',
      message: 'Ujian Akhir Semester akan dimulai tanggal 10 Januari.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    return currentUser;
  }
}
