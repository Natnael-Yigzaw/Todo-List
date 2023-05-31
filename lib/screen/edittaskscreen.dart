import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:provider/provider.dart';
import '../provider/todoprovider.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task',
           style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white54,
          ),
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
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Title',
               style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2980B9),
                        fontSize: 16,
                  ),
              ),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title here',
              ),
            ),
            const SizedBox(height: 16.0),
             Text(
              'Description',
              style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2980B9),
                        fontSize: 16,
                  ),
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter description here',
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0A4C71),
        foregroundColor: Colors.white54,
        onPressed: () {
              Task updatedTask = Task(
                id: widget.task.id,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                dueDate: widget.task.dueDate,
                isCompleted: widget.task.isCompleted,
                isFavorite: widget.task.isFavorite,
              );

              final todoProvider = Provider.of<TodoProvider>(context, listen: false);
              todoProvider.updateTask(updatedTask);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Task updated successfully.',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Color(0xFF0A4C71),
                ),
              );
              Navigator.pop(context);
            },
        child: const Icon(Icons.save),
      ),
    );
  }
}
