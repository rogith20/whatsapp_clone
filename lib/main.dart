import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/camera_screen.dart';
import 'package:my_whatsapp/Pages/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        tabBarTheme: const TabBarTheme(
            labelColor: Colors.white, unselectedLabelColor: Colors.white54),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF075E54),
            titleTextStyle: TextStyle(fontSize: 22),
            actionsIconTheme: IconThemeData(color: Colors.white)),
      ),
      home: const HomePage(),
    );
  }
}
