import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyek_mobile/data/menu.dart';
import 'package:proyek_mobile/widget/card_menu.dart';

class DashboardScreen extends StatefulWidget {
  final String username;
  const DashboardScreen({super.key, required this.username});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Menu> _menus = [];
  @override
  void initState() {
    super.initState();
    _menus = menus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6C63FF), Color(0xFF4840BB)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/thumbnails/027/951/137/small/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png',
                    ),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi,${widget.username}',
                          style: GoogleFonts.poppins(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.poppins(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Center(
                child: Text(
                  'Explore the menu',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _menus.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CardMenu(menu: _menus[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
