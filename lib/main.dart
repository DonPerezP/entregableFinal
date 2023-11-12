import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/services/students_service.dart';
import 'package:notes_crud_local_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ActualOptionProvider()),
          ChangeNotifierProvider(create: (_) => StudentsService())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Entregable 2',
            initialRoute: "main",
            routes: {'main': (_) => HomeScreen()}));
  }
}
