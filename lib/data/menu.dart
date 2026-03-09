import 'package:flutter/material.dart';
import 'package:proyek_mobile/core/app_routes.dart';

class Menu {
  final String name;
  final String imageUrl;
  final Function(BuildContext) onTap;
  final String description;

  const Menu({
    required this.name,
    required this.imageUrl,
    required this.onTap,
    required this.description,
  });
}

final List<Menu> menus = [
  Menu(
    name: 'Prisma',
    imageUrl:
        "https://awsimages.detik.net.id/community/media/visual/2022/07/11/prisma-segi-enam.jpeg?w=650",
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.prisma);
    },
    description: 'calculator canggih',
  ),
  Menu(
    name: 'Calculator',
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Casio_calculator_JS-20WK_in_201901_002.jpg/250px-Casio_calculator_JS-20WK_in_201901_002.jpg",
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.calculator);
    },
    description: 'calculator canggih',
  ),
  Menu(
    name: 'Stopwatch',
    imageUrl:
        "https://raviscientific.in/wp-content/uploads/2019/01/diamond-mechanical-stopwatch.jpg",
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.stopwatch);
    },
    description: 'calculator canggih',
  ),
  Menu(
    name: 'Jumlah Angka',
    imageUrl:
        "https://centrepointschools.com/blogs/wp-content/uploads/2024/08/number-systen.jpg",
    onTap: (BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.perhitungan);
    },
    description: 'calculator canggih',
  ),
];
