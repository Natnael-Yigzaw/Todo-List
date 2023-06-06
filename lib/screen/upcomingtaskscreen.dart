import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:my_todo/screen/taskdetailscreen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'homescreen.dart';

class UpcomingTasksScreen extends StatelessWidget {
  const UpcomingTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final List<Task> upcomingTasks = todoProvider.getUpcomingTasks();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A4C71),
        title: Text(
          'Upcoming Tasks',
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
        child: upcomingTasks.isEmpty
            ? Center(
                child: Text(
                  'There are no upcoming tasks.',
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
                itemCount: upcomingTasks.length,
                itemBuilder: (context, index) {
                  final task = upcomingTasks[index];
                  final taskDate = task.dueDate;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TaskDescriptionScreen(task: task),
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
                        color: Colors.white70,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            child: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                         trailing: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat.EEEE().format(taskDate),
                              style: TextStyle(
                                fontSize: 14.0,
                                //fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                        ),
                      ),
                    ),
                    )
                  );
                },
              ),
      ),
    );
  }
}
