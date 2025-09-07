import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../widgets/flag_tile.dart';
import '../../../available_teachers/presentation/screens/available_teacher_screen.dart';
import '../../../booked_lessons/presentation/screens/booked_lesson_screen.dart';

class StudentLessonList extends ConsumerWidget {
  const StudentLessonList({super.key, required this.whereTo});
  final String whereTo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const languages = [
      'Bangla',
      'Dutch',
      'Russian',
      'English',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16), // optional padding inside container
      itemCount: languages.length,
      itemBuilder: (context, i) {
        final langs = languages[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BounceInTile(
            index: i,
            whereTo: whereTo,
            langs: langs,
          ),
        );
      },
    );
  }
}

class BounceInTile extends StatefulWidget {
  const BounceInTile({
    Key? key,
    required this.index,
    required this.whereTo,
    required this.langs,
  }) : super(key: key);

  final int index;
  final String whereTo;
  final String langs;

  @override
  _BounceInTileState createState() => _BounceInTileState();
}

class _BounceInTileState extends State<BounceInTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define the animation (starts below and bounces into position)
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.3), // Start from below
      end: Offset.zero, // End at the normal position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut, // Bouncy effect
      ),
    );

    // Trigger the animation after a delay based on the index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is removed
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => widget.whereTo == 'Teacher Availability'
                  ? TeacherAvailabilityScreen(language: widget.langs)
                  : BookedSchedulesScreen(language: widget.langs),
            ),
          );
        },
        child: FlagTile(
          countryName: widget.langs,
          flagAssetPath: 'assets/${widget.langs}.png',
        ),
      ),
    );
  }
}
