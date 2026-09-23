import 'package:flutter/material.dart';
import 'go router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        // brightness: Brightness.dark,
        fontFamily: "font2",
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
