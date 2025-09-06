import 'package:data_pollex/src/features/student/available_teachers/presentation/screens/available_teacher_screen.dart';
import 'package:flutter/material.dart';

import '../../../booked_lessons/presentation/screens/booked_lesson_screen.dart';

class LanguageOptionScreen extends StatelessWidget {
  const LanguageOptionScreen({super.key, required this.whereTo});

  final String whereTo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    final languages = [
      {'name': 'English', 'icon': Icons.language},
      {'name': 'Bangla', 'icon': Icons.translate},
      {'name': 'French', 'icon': Icons.school},
      {'name': 'Russian', 'icon': Icons.public},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Availability"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLargeScreen ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => whereTo == 'Teacher Availability'
                        ? TeacherAvailabilityScreen(
                            language: lang['name'] as String)
                        : BookedSchedulesScreen(
                            language: lang['name'] as String,
                          ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.purpleAccent.withOpacity(0.7),
                        Colors.purpleAccent
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(lang['icon'] as IconData,
                          size: 48, color: Colors.white),
                      const SizedBox(height: 16),
                      Text(
                        lang['name'] as String,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
