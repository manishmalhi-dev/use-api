import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/api%20links/api_link.dart';
import 'package:fake_api_demo_app/model%20class/collection_get_data.dart';
import 'package:fake_api_demo_app/pages/home%20page/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class GetSingleItem extends StatefulWidget {
  String id ;
  String object;

   GetSingleItem({super.key, required this.id,required this.object });

  @override
  State<GetSingleItem> createState() => _GetSingleItemState();
}

class _GetSingleItemState extends State<GetSingleItem> {
  @override
  void initState() {
    super.initState();
    getData();
  }

 CollectionGetData? newCollection;

  Future<void> getData()async{
    try{
      final linkIs ="${GetSingleData.url(widget.id, widget.object)}";
      final response = await http.get(Uri.parse(linkIs),
        headers: {"x-api-key": ApiLink.link, "Content-Type": "application/json"},
      );
      if(response.statusCode ==200){
        Map<String,dynamic> finalResponse = jsonDecode(response.body);
        setState(() {
          newCollection = CollectionGetData.fromJson(finalResponse);
        });
      }
    }catch(e){
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: newCollection==null?null:Text(newCollection!.name),
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow,
      ),
      body:newCollection==null?Center(child: CircularProgressIndicator(),):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  widgetIs("id ", newCollection!.id),
                  widgetIs("name ", newCollection!.name),
                  widgetIs("price ", newCollection!.modelData.price),
                  widgetIs("year ", newCollection!.modelData.year),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
