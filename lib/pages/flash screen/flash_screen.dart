import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {

  @override
  void initState() {
    super.initState();
    changeScreen();
  }
  Future<void> changeScreen() async{
    final pref = await SharedPreferences.getInstance();
    final login = pref.getBool("userLogin");
    Future.delayed(const Duration(seconds: 3), () {
      if(login==true){
        context.go('/HomePage');
      }
      else{
        context.go('/RegisterPage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Image.asset('assets/images/image01.png'),
            Text("Welcome API's",style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'font1'),),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
