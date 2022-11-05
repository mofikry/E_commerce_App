import 'package:e_commerce/core/network/cache_helper.dart';
import 'package:e_commerce/features/login/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
      onPressed: () {
        CacheHelper.removeData(key: 'token').then((value) {
          if (value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        });
      },
      child: Text('Logout'),
    )));
  }
}
