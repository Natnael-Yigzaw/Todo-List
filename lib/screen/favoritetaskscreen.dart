import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/screen/taskdetailscreen.dart';
import 'package:provider/provider.dart';
import '../model/task.dart';
import '../provider/todoprovider.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final favoriteTasks = todoProvider.favoriteTasks;

    // ignore: no_leading_underscores_for_local_identifiers
    void _navigateToTaskDescription(BuildContext context, Task task) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDescriptionScreen(task: task),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A4C71),
        title: const Text(
          'Favorite Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white54,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white54,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white54,
        child: favoriteTasks.isEmpty
            ?  Center(
                child: Text(
                  'No Favorite Tasks.',
                  style: GoogleFonts.playfairDisplay(
                    textStyle:  const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                itemCount: favoriteTasks.length,
                itemBuilder: (context, index) {
                  final task = favoriteTasks[index];
                  return Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white70,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () => _navigateToTaskDescription(context, task),
                          child: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                              color: Colors.black87,
                            ),
                          ),
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
