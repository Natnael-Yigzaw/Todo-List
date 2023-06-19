import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:my_todo/model/task.dart';
import 'package:my_todo/screen/searchtaskscreen.dart';
import 'package:my_todo/widget/appbardrawer.dart';
import 'package:my_todo/widget/tasklist.dart';
import 'package:my_todo/screen/addtaskscreen.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool notificationShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      final tasksCount = todoProvider.getTasksCountForToday();
      if (tasksCount > 0 && !notificationShown) {
        initializeNotifications();
        showNotification(tasksCount);
        setState(() {
          notificationShown = true;
        });
      }
    });
  }

  void initializeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
        ),
      ],
    );
  }

  void showNotification(int tasksCount) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'basic_channel',
        title: 'You have $tasksCount tasks for today',
        body: 'See the details in the Today option',
        payload: {'screen': 'today'},
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Todo',
             style: GoogleFonts.quicksand( 
              textStyle: TextStyle(
               fontWeight: FontWeight.bold,          
               color: Colors.white54,
               fontSize: 18,
             ),
           ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white54,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white54,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchTaskScreen(),
                ),
              );
            },
          ),
          Consumer<TodoProvider>(
            builder: (context, todoProvider, _) {
              final allTasksCompleted = todoProvider.areAllTasksCompleted();
              return IconButton(
                icon: Icon(
                  allTasksCompleted
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: Colors.white54,
                ),
                onPressed: () {
                  todoProvider.toggleAllTasksCompleted(!allTasksCompleted);
                  _showRemainingTasksSnackBar(context, todoProvider.tasks);
  
                },
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Consumer<TodoProvider>(
      builder: (context, todoProvider, _) {
        final List<Task> tasks = todoProvider.tasks;
        return TaskListWidget(
          tasks: tasks,
        );
      },
      ),  
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0A4C71),
        foregroundColor: Colors.white,
        elevation: 8.0,
        hoverElevation: 8.0,
        focusElevation: 4.0,
        disabledElevation: 0.0,
        tooltip: 'Add',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskAddScreen(),
            ),
          );
        },
        child: Image.asset(
          'assets/icons/addi1.png',
          height: 25,
          width: 25,
          color: Colors.white54,
        ),
      ),
      
    );
  }
    void _showRemainingTasksSnackBar(BuildContext context, List<Task> tasks) {
  final remainingTasksCount = tasks.where((task) => !task.isCompleted).length;
  if (remainingTasksCount == 0) {
    final snackBar = SnackBar(
      content: Text('Congratulations! You have completed all tasks'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green, 
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
