import 'package:fake_api_demo_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'go router/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => SetTheme(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<SetTheme>();
    return MaterialApp.router(
      theme: ThemeData(fontFamily: "font2", brightness: theme.bright),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
