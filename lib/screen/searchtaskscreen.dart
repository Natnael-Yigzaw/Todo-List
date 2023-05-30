import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/screen/taskdetailscreen.dart';
import 'package:provider/provider.dart';
import '../provider/todoprovider.dart';

class SearchTaskScreen extends StatefulWidget {
  const SearchTaskScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchTaskScreenState createState() => _SearchTaskScreenState();
}

class _SearchTaskScreenState extends State<SearchTaskScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isSearchItemFound = true;

  @override
  void initState() {
    super.initState();
    _loadTasksFromProvider();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Task>> _loadTasksFromProvider() async {
    final taskProvider = Provider.of<TodoProvider>(context, listen: false);
    _tasks = taskProvider.tasks;
    _filteredTasks = _tasks;
    return taskProvider.tasks;
  }

  _onSearchTextChanged(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _filteredTasks = [];
      });
      return;
    }

    if (_tasks.isEmpty) {
      _tasks = await _loadTasksFromProvider();
    }

    setState(() {
      _filteredTasks = _tasks
          .where((task) =>
              task.title.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
      _isSearchItemFound = _filteredTasks.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueGrey[300],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchTextChanged,
          onSubmitted: _onSearchTextChanged,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,
             color: Colors.blueGrey[300],
            ),
            onPressed: () {
              final searchText = _searchController.text;
              _onSearchTextChanged(searchText);
            },
          ),
        ],
      ),
      body: _isSearchItemFound
          ? ListView.builder(
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskDescriptionScreen(task: task),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
                child: Text(
                  'There is no Task with such title.',
                  style: GoogleFonts.playfairDisplay(
                    textStyle:  const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
    );
  }
}
