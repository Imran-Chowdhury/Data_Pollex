import 'package:data_pollex/src/features/student/dashboard/presentation/screens/language_option_screen.dart';
import 'package:data_pollex/src/features/student/upcoming_schedules/presentation/screens/upcoming_schedule_screen.dart';
import 'package:data_pollex/src/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/color.dart';
import '../../../../teacher/dashboard/presentation/widgets/dashboard_tile.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DashboardHeader(),
            const SizedBox(height: 20),

            // Lesson tiles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Upcoming Lessons Tile
                  LessonCard(
                    title: 'Upcoming Lessons',
                    icon: Icons.schedule,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpcomingSchedulesScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Booked Lessons Tile
                  LessonCard(
                    title: 'Booked Lessons',
                    icon: Icons.schedule,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LanguageOptionScreen(
                            whereTo: 'Booked Lessons',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Availability Tile
                  LessonCard(
                    title: 'Availability',
                    icon: Icons.schedule,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageOptionScreen(
                            whereTo: 'Teacher Availability',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Dashboard Card
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // color: color,
      color: CustomColor.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: CustomColor.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    color: CustomColor.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
