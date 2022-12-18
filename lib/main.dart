import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:internship_app/home_screen.dart';

import 'package:internship_app/providers/time_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  //initializing Hive
  await Hive.initFlutter();

  // Open the "items" box to store list
  var box = await Hive.openBox('itemsBox');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
