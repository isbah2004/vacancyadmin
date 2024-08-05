import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vacancy_admin/provider/auth_provider.dart';
import 'package:vacancy_admin/provider/home_index_provider.dart';
import 'package:vacancy_admin/provider/password_visibility_provider.dart';
import 'package:vacancy_admin/provider/upload_provider.dart';
import 'package:vacancy_admin/screens/homescreen/home_screen.dart';
import 'package:vacancy_admin/screens/splashscreen/splash_screen.dart';
import 'package:vacancy_admin/theme/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => VisibilityProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => HomeIndexProvider()),
      ChangeNotifierProvider(create: (context) => UploadProvider()),
    ],
    child: MaterialApp(
      title: 'Vacancy admin',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: AppTheme.lightTheme,
    ),
  ));
}
