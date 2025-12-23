import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/mock_database.dart'; // User class is here
import 'course_detail_screen.dart';

class ClassesScreen extends StatelessWidget {
  // We need to access the current user to filter courses
  // Since BaseScreen doesn't pass it yet, we might need to rely on MockDatabase.currentUser 
  // IF BaseScreen isn't updated. 
  // But our plan says BaseScreen handles it. Let's assume BaseScreen will be updated.
  // Actually, wait, BaseScreen creates the screens in initState now.
  // So we just need to add the field here.
  
  // NOTE: Ideally, we should pass the user.
  // Since I don't want to break the build if BaseScreen isn't updated in same step, 
  // I will check BaseScreen usage.
  // BaseScreen calls: const ClassesScreen(), which is 0 arguments.
  // I need to update both.
  
  // But wait, BaseScreen DOES have `User user` now.
  // And it initializes `_screens` with `HomeScreen(user: widget.user)`.
  // It currently has `const ClassesScreen()`.
  // I will change this file to accept `user` optionally or required, 
  // but for now I'll just change the fetching logic to use the *passed* user if possible.
  
  // Actually, to make it clean:
  // 1. Update this class to accept `User user`.
  // 2. Update `BaseScreen` to pass it.
  
  // Let's execute this tool on this file first.
  
  final User? user; // Optional for now to avoid immediate break if called without
  
  const ClassesScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    // Fallback to currentUser if null (though it shouldn't be if wired correctly)
    final currentUser = user ?? MockDatabase.currentUser; 
    final courses = MockDatabase.getCoursesForUser(currentUser.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelas Saya'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Semester 7',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.8,
                 crossAxisSpacing: 16,
                 mainAxisSpacing: 16,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                course.code,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  course.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Progress',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 4),
                                    LinearProgressIndicator(
                                      value: course.progress,
                                      backgroundColor: Colors.grey[200],
                                      color: AppColors.accent,
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(course.progress * 100).toInt()}%',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
