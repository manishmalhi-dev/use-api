import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_link.dart';
import 'package:fake_api_demo_app/pages/home%20page/home_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category/laptops_category.dart';
import 'category/phones_category.dart';
import 'category/tablets_category.dart';
import 'category/top_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;
  List<Widget> listIs = [PhonesCategory(),LaptopsCategory(), TabletsCategory()];

  // Future<void> getData() async {
  //   final response = await http.get(
  //     Uri.parse(Collections.collection),
  //     headers: {"x-api-key": Config.apiKey, "Content-Type": "application/json"},
  //   );
  //   final newResponse = jsonEncode(response.body);
  //   print(newResponse);
  //   print(response.statusCode);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("home Page"),
          backgroundColor: Colors.yellow
      // actions: [IconButton(onPressed: (){}, icon: Icon(Icons.home))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TopCategory(
              onNameSelected: (name) {
                setState(() {
                  index = name;
                });
              },
            ),
          ),
          SizedBox(height: 50,),
          Container(
            child: listIs[index],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            showModalBottomSheet(isScrollControlled:true, context: context, builder: (context){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeBottomSheet()
              );
            });
          }),
    );
  }
}


