import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/screen/favoritetaskscreen.dart';
import 'package:my_todo/screen/homescreen.dart';
import 'package:my_todo/screen/todaytaskscreen.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF0A4C71),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/todolist.png',
                      width: 30,
                      height: 30,
                      color: Colors.white54,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Menu',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 82, 106, 116),
                ),
                title: Text(
                  'Home',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.today,
                  color: Color.fromARGB(255, 82, 106, 116),
                ),
                title: Text(
                  'Today',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const TodayScreen(),
                    ),
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.star_border_purple500_outlined,
                  color: Color.fromARGB(255, 82, 106, 116),
                ),
                title: Text(
                  'Important',
                  style: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                           const FavoriteTasksScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}