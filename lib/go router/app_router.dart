import 'package:fake_api_demo_app/pages/flash%20screen/flash_screen.dart';
import 'package:fake_api_demo_app/pages/home%20page/get_single_item.dart';
import 'package:fake_api_demo_app/pages/home%20page/home/home_page.dart';
import 'package:fake_api_demo_app/pages/register%20pages/register_page.dart';
import 'package:go_router/go_router.dart';
import '../pages/login page/login_page.dart';

final GoRouter router = GoRouter(
   initialLocation: '/FlashScreen',

   routes: [
     GoRoute(path: '/FlashScreen', builder: (context, state)=>FlashScreen()),
      GoRoute(path: '/RegisterPage',name : 'RegisterPage' ,builder: (context, state)=> RegisterPage()),
      GoRoute(path: '/LoginPage', name : 'LoginPage', builder: (context, state)=> LoginPage()),
      GoRoute(path: '/HomePage',builder: (context, state)=> HomePage()),
     GoRoute(
         path: '/GetSingleItem',
         builder: (context, state) {
           final data = state.extra as Map<String,String>;
           return GetSingleItem(id: data["id"]!,object: data["object"]!,);
         }),
   ]
);