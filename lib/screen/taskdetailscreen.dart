import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:provider/provider.dart';

class TaskDescriptionScreen extends StatefulWidget {
  final Task task;

  const TaskDescriptionScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskDescriptionScreenState createState() => _TaskDescriptionScreenState();
}

class _TaskDescriptionScreenState extends State<TaskDescriptionScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    isFavorite = todoProvider.isTaskFavorite(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy');
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white54,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
                todoProvider.toggleFavorite(widget.task);

                // Show a snackbar message based on the task's favorite status
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite
                          ? 'Task added to favorites.'
                          : 'Task removed from favorites.',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                    backgroundColor: isFavorite
                        ? Colors.amber 
                        : Colors.red,
                  ),
                  
                );
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              widget.task.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8.0),
                Text(dateFormat.format(widget.task.dueDate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
