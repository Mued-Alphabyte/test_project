import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Provider/to_do_provider.dart';
import 'package:test_app/sensor_page.dart';
import 'package:test_app/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartPage(),
      ),
    );
  }
}

