import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:proyek_mobile/core/app_routes.dart';

class Menu {
  final String name;
  final List<List<dynamic>> icon;
  final Function(BuildContext) onTap;
  final String description;

  const Menu({
    required this.name,
    required this.icon,
    required this.onTap,
    required this.description,
  });
}

final List<Menu> menus = [
  Menu(
    name: 'Pyramid',
    icon: HugeIcons.strokeRoundedPyramid,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.pyramid);
    },
    description:
        'Calculate the volume and surface area of various pyramidal shapes instantly.',
  ),
  Menu(
    name: 'Calculator',
    icon: HugeIcons.strokeRoundedCalculator,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.calculator);
    },
    description:
        'A versatile tool for performing basic and advanced arithmetic operations.',
  ),
  Menu(
    name: 'Stopwatch',
    icon: HugeIcons.strokeRoundedStopWatch,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.stopwatch);
    },
    description:
        'Measure elapsed time with high precision for your tasks and workouts.',
  ),
  Menu(
    name: 'Character Analysis',
    icon: HugeIcons.strokeRoundedTextFont,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.characterMap);
    },
    description:
        'Visualize the frequency and distribution of characters within any given text.',
  ),
  Menu(
    name: 'Javanese Weton',
    icon: HugeIcons.strokeRoundedCalendar01,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.jawa);
    },
    description:
        'Determine the Javanese weton (day and pasaran) based on a Gregorian date.',
  ),
  Menu(
    name: 'About',
    icon: HugeIcons.strokeRoundedInformationSquare,
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.about);
    },
    description:
        'Information about the development team behind this application.',
  ),
];
