import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBUd-j4zBJFV8jIQ6huVw-IdsyV0CTKEeE",
      appId: "1:137561112569:android:e8f0759fee7335b6b2c728",
      messagingSenderId: "137561112569",
      projectId: "hostel-199d5",
      storageBucket: "hostel-199d5.appspot.com",
    ),
  );
  runApp(ComplaintApp());
}

class ComplaintApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue, // Primary color for app
        hintColor: const Color.fromARGB(255, 0, 0, 0), // Accent color for highlights
        scaffoldBackgroundColor: Colors.white, // Background color

        // AppBar Theme
        appBarTheme: AppBarTheme(
          // color: Colors.blue,
          // titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),

        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 62, 164, 247),
          ),
        ),

        // Input Decoration Theme for TextFields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 254, 254),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

