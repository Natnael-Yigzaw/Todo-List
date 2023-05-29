/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/screen/searchtaskscreen.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Color.fromARGB(255, 82, 106, 116)),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
         IconButton(
                icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 82, 106, 116),
                ),
                onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const SearchTaskScreen(),
                  ), 
                ); 
                },
              ),
              const SizedBox(
                width: 3,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert,
                color: Color.fromARGB(255, 82, 106, 116),
                ),
                onPressed: () {},
              ),
      ],
      expandedHeight: 230,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'TODO',
         style: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
         )),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 38, 50, 56),
                Color.fromARGB(255, 38, 50, 56),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}*/