import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:provider/provider.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({Key? key}): super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskAddScreenState createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedDate = '';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TodoProvider>(context, listen: false);

      final task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: DateTime.parse(_selectedDate),
        isCompleted: false,
        isFavorite: false,
        id: '',
      );
  
  taskProvider.addTask(task); 
    
    ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Task added successfully.',
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
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF0A4C71),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white54,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF0A4C71),
            title: Text(
              'New Task',
              style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              )),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
           child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2980B9),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                       if (value.trim().isEmpty) {
                        return 'Title cannot be just spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Description',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2980B9),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Enter task description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      if (value.trim().isEmpty) {
                        return 'Description cannot be just spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Due Date',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2980B9),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy-MM-dd',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    onChanged: (value) =>
                        setState(() => _selectedDate = value),
                    onSaved: (value) => _selectedDate = value!,
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: _submitTask,
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(320, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF0A4C71),),
                    ),
                    child: Text(
                      'Add',
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}