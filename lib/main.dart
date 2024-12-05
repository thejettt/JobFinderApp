import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/job_provider.dart';
import './screens/home_screen.dart';
import './screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobProvider()),
      ],
      child: MaterialApp(
        title: 'Job Finder App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
