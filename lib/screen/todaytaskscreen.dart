import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:my_todo/screen/taskdetailscreen.dart';
import 'package:provider/provider.dart';
import 'homescreen.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final List<Task> todayTasks = todoProvider.getTasksForToday();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A4C71),
        title: Text(
          'Today',
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white54,
          ),
          onPressed: () {
            Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.white54,
        child: todayTasks.isEmpty
            ? Center(
                child: Text(
                  'There is no task for today.',
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDescriptionScreen(task: task),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color:  Colors.white70,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                    ),
                  );
                },
              ),
      ),
    );
  }
}
