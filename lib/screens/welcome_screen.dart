import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../core/constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryCoffee.withOpacity(0.9),
              AppColors.primaryCoffee.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.work_outline,
                size: 100,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                'Welcome to Job Finder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Find your dream job here',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: AppColors.primaryCoffee,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
