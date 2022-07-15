import 'package:flutter/material.dart';
import 'package:poc_demo/core/navigator/router_navigator.dart';
import 'package:poc_demo/features/details/presentation/user_interface/details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC Demo ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POC-DEMO"),
      ),
      body: Center(
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.arrow_forward_sharp),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DetailsScreen()));
          },
        ),
      ),
    );
  }
}
