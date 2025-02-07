import 'package:flutter/material.dart';
import 'package:flutter_prof_app/screens/sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://btnepspxakfjasxhjcys.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0bmVwc3B4YWtmamFzeGhqY3lzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyMjMxMTgsImV4cCI6MjA1Mzc5OTExOH0.93aYGDDUGK7M0Nmd0wxnp_YngX0CC39z9-i2e4P74h8',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "NewPeninimMT",
      ),
      home: SignIn(),
    );
  }
}