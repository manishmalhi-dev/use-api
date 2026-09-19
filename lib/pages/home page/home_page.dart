import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/pages/home%20page/home_bottom_sheet.dart';
import 'package:fake_api_demo_app/pages/home%20page/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api links/api_link.dart';
import '../../model class/collection_get_data.dart';
import 'home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> pages = [HomeWidget(),ProfileWidget()];
  int selected =0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home Page",style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(),
      body: pages[selected],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
          onDestinationSelected: (index){
          setState(() {
            selected = index;
          });
          },
          destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
      ]),


    );
  }
}

