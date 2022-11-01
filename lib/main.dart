import 'package:e_commerce/services/dio_helper.dart';
import 'package:flutter/material.dart';

import 'features/login/presentation/views/login_screen.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF9F9F9)),
      home: LoginScreen(),
    );
  }
}
