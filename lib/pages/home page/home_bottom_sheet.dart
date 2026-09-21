import 'dart:convert';

import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/api%20links/api_link.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({super.key});

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController year = TextEditingController();

  String collectionsName = "laptop";

  final formKey = GlobalKey<FormState>();

  Future<void> postData()async{
    String finalName = name.text.trim();
    String finalPrice = price.text.trim();
    String finalYear = year.text.trim();

    try{
      setState(() {
        isLoading = true;
      });
      final response = await http.post(Uri.parse(AddCollection.Login(collectionsName)),
          body: jsonEncode({
            "name":finalName,
            "data":{
              "year" : finalYear,
              "price" : finalPrice,
            }
          }),
          headers: {
            "Content-Type":"application/json",
            "x-api-key" : ApiKey.key,
          }
      );
      setState(() {
        isLoading = false;
      });
      if(response.statusCode==200||response.statusCode==201){
        name.clear();
        price.clear();
        year.clear();
        Navigator.pop(context, true);
      }
      else {
      }

    }catch(e){
      print(e);
    }
  }
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading==true? Center(child: CircularProgressIndicator()):SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: Divider(
                thickness: 4,
                color: Colors.grey.shade400,
                radius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Categories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, size: 26),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Collections",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  CollectionButtons(backData:(String value){
                    setState(() {
                      collectionsName = value;
                    });
                  },),

                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: name,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                        return "please enter name";
                      }return null;
                    }),
                    decoration: InputDecoration(
                      hintText: "Product name ",
                      prefixIcon: Icon(Icons.note_add_sharp),
                      suffixIcon: IconButton(onPressed: (){
                      }, icon: Icon(Icons.close)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Price",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: price,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                        return "please enter price";
                      }return null;
                    }),
                    decoration: InputDecoration(
                      hintText: "Product price ",
                      prefixIcon: Icon(Icons.note_add_sharp),
                      suffixIcon: IconButton(onPressed: (){
                      }, icon: Icon(Icons.close)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Year",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextFormField(
                    controller: year,
                    validator: ((value) {
                      if(value==null||value.isEmpty){
                        return "please enter year";
                      }return  null;
                    }),
                    decoration: InputDecoration(
                      hintText: "Product year ",
                      prefixIcon: Icon(Icons.note_add_sharp),
                      suffixIcon: IconButton(onPressed: (){
                      }, icon: Icon(Icons.close)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          postData();
                        }
                      },
                      label: Text("Add collection"),
                      icon: Icon(Icons.task),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CollectionButtons extends StatefulWidget {
 const CollectionButtons({super.key,required this.backData});

   final Function(String) backData;

  @override
  State<CollectionButtons> createState() => _CollectionButtonsState();
}

class _CollectionButtonsState extends State<CollectionButtons> {

  List<String> collectionName = ["laptop", "phone", "tablet"];
  int buttonColor = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
        return  ElevatedButton.icon(
          onPressed: () {
            setState(() {
              buttonColor=index;
              widget.backData(collectionName[index]);
            });
          },
          label: Text(collectionName[index]),
          icon: Icon(Icons.work),
          style: ElevatedButton.styleFrom(
            foregroundColor:  buttonColor==index ?Colors.black:Colors.white,
            backgroundColor: buttonColor==index ?Colors.yellow:Colors.grey,
          ),
        );
      }, separatorBuilder: (context,index){
        return SizedBox(width: 10,);
      }, itemCount: collectionName.length
      ),
    );
  }
}
