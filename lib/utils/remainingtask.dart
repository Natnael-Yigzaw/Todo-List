import 'package:flutter/material.dart';

void showRemainingTasksSnackBar(BuildContext context, int remainingTasksCount) {
  if (remainingTasksCount == 0) {
    final snackBar = SnackBar(
      content: Text('Congratulations! You have completed all tasks'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    final snackBar = SnackBar(
      content: Text('$remainingTasksCount tasks remain'),
      duration: const Duration(seconds: 1),
      backgroundColor: Color(0xFF0A4C71),
      shape: RoundedRectangleBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
