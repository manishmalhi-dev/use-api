import 'dart:convert';

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

  String collectionsName = "Laptop";

  Future<void> postData()async{
    String finalName = name.text.trim();
    String finalPrice = price.text.trim();
    String finalYear = year.text.trim();

    try{
      String finalLink = "https://api.restful-api.dev/collections/${collectionsName.toLowerCase()}/objects";
      final response = await http.post(Uri.parse(finalLink),
          body: jsonEncode({
            "name":finalName,
            "price" : finalPrice,
            "year" : finalYear,
          }),
          headers: {
            "Content-Type":"application/json",
            "x-api-key" : "f1acc627-be6b-46ed-be1d-b73583d3de56",
          }
      );
      if(response.statusCode==200||response.statusCode==201){
        name.clear();
        price.clear();
        year.clear();
        Navigator.pop(context);
        print(response.statusCode);
        print("response is-- ");
        print(response.body);
      }
      else {
        print("data can't be post in api ");
      }

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(collectionsName),
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
                TextField(
                  controller: name,
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
                TextField(
                  controller: price,
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
                TextField(
                  controller: year,
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
                      postData();
                    },
                    label: Text("Add collection"),
                    icon: Icon(Icons.task),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
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

  List<String> collectionName = ["Laptop", "Phones", "Tablets"];
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
            foregroundColor: Colors.white,
            backgroundColor: buttonColor==index ?Colors.blue:Colors.grey
          ),
        );
      }, separatorBuilder: (context,index){
        return SizedBox(width: 10,);
      }, itemCount: collectionName.length
      ),
    );
  }
}
