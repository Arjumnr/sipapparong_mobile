import 'dart:async';

import 'package:flutter/material.dart';
import 'Data/Database/db_provider.dart';
import 'View/Login/form_login.dart';
import 'bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

DatabaseProvider databaseProvider = DatabaseProvider();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    starSplashScreen();
  }

  starSplashScreen() async {
    var duration = const Duration(seconds: 2);

    return Timer(duration, () {
      navigateUser();
    });
  }

  navigateUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool token = await databaseProvider.checkToken();

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == false ? const FormLogin() : const BottomNavigation(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset('asset/images/logo-splash-screen.png'),
          ),
        ),
      ),
    );
  }
}
