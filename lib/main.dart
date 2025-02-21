import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/screens/home.dart';
import 'constants/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Reset status bar to default (native color)
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:
        Colors.transparent, // Transparent so it shows system default
    statusBarIconBrightness:
        Brightness.dark, // Use dark icons if status bar is light
    systemNavigationBarColor: Colors.white, // White bottom navigation bar
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData().copyWith(
        appBarTheme: AppBarTheme(
          color: tdBGColor,
        ), // Custom AppBar color
        scaffoldBackgroundColor: tdBGColor, // Custom scaffold color
      ),
    );
  }
}
