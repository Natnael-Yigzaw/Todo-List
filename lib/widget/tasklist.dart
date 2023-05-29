import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:my_todo/screen/edittaskscreen.dart';
import 'package:my_todo/screen/taskdetailscreen.dart';
import 'package:provider/provider.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;

  const TaskListWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TodoProvider>(context);
    final List<Task> tasks = taskProvider.tasks;

    return tasks.isEmpty
        ?  Center(
           child: Text(
                  'Make Your First Todo.',
                  style: GoogleFonts.playfairDisplay(
                    textStyle:  const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                 ),
             ),
           ),
          )
    : ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Material(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            elevation: 20,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TaskDescriptionScreen(task: task),
                  ),
                );
              },
              title: Text(
                task.title,
                style: TextStyle(
                  color: Colors.black87,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  final taskProvider =
                      Provider.of<TodoProvider>(context, listen: false);
                  taskProvider.completeTask(index, value ?? false);
                  _showRemainingTasksSnackBar(context, taskProvider.tasks);

                },
              ),
              trailing: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black26,
                ),
                itemBuilder: (BuildContext context) => [
                   const PopupMenuItem<String>(
                    value: 'edit',
                    child: SizedBox(
                      width: 125,
                      height: 40,
                    child: ListTile(
                          dense: true,
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                      ),
                    ),
                   const PopupMenuItem<String>(
                    value: 'delete',
                    child: SizedBox(
                      width: 125,
                      height: 40,
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
                   ),
                ],
                onSelected: (String value) {
                  if (value == 'edit') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditTaskScreen(task: task),
                      ),
                    );
                  } else if (value == 'delete') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Task'),
                          content:
                              const Text('Are you sure you want to remove this task?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final taskProvider =
                                    Provider.of<TodoProvider>(context, listen: false);
                                taskProvider.removeTask(task);
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Task deleted successfully',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red, 
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.red[400]),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                elevation: 10,
                offset: const Offset(0, 10),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showRemainingTasksSnackBar(BuildContext context, List<Task> tasks) {
  final remainingTasksCount = tasks.where((task) => !task.isCompleted).length;
  if (remainingTasksCount == 0) {
    final snackBar = SnackBar(
      content: Text('Congratulations! You have completed all tasks'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green, // Adjust the background color of the SnackBar
      //behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
       // borderRadius: BorderRadius.circular(8.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    final snackBar = SnackBar(
      content: Text('$remainingTasksCount tasks remain'),
      duration: const Duration(seconds: 1),
      backgroundColor: Color(0xFF0A4C71), 
      //behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        //borderRadius: BorderRadius.circular(8.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
}
