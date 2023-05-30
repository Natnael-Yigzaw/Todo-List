import 'package:flutter/material.dart';
import 'package:my_todo/provider/todoprovider.dart';
import 'package:provider/provider.dart';
import 'screen/splashscreen.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
           color : Color(0xFF0A4C71),
        ),
      ),
      home: SplashScreen(),
    );
  }
}