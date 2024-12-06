import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/job_provider.dart';
import './providers/user_provider.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/welcome_screen.dart';
import './screens/all_jobs_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), // Tambahkan UserProvider
      ],
      child: MaterialApp(
        title: 'Job Finder',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomeScreen(),
          '/all-jobs': (context) => AllJobsTab(),
        },
      ),
    );
  }
}
