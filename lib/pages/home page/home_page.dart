import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/pages/home%20page/home_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api links/api_link.dart';
import '../../model class/collection_get_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  int colorIndex =0;
  List<String> name = ["phone", "laptop", "tablet"];
  String categoryName = "phone";

  List<CollectionGetData> dataIs =[];

  Future<void> getData() async {
    try{
      final response = await http.get(
        Uri.parse(AddCollection.Login(categoryName)),
        headers: {"x-api-key": ApiLink.link, "Content-Type": "application/json"},
      );
      List newResponse = jsonDecode(response.body);

      print("----------response is this ------------");
      print(response.body);
      print(response.statusCode);
      setState(() {
        dataIs = newResponse.map((iteam)=> CollectionGetData.fromJson(iteam)).toList();
      });

    }catch(e){
      print(e);
    }
  }

  // bool result = false;

  void floatingButton() async{
   final result = await showModalBottomSheet(
        isScrollControlled:true,
        context: context,
        builder: (context){
          return HomeBottomSheet();
    });
   if(result==true){
     getData();
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("home Page"),
          backgroundColor: Colors.yellow
      ),
      body: Column(
        children: [
          Text(categoryName),

      SizedBox(
        height: 40,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(width: 30);
          },
          scrollDirection: Axis.horizontal,
          itemCount: name.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorIndex==index?Colors.yellow :null,
              ),
              onPressed: () {
                setState(() {
                  colorIndex = index;
                  categoryName = name[index];
                  getData();
                });
              },
              child: Text(name[index]),
            );
          },
        ),
      ),
          SizedBox(height: 20,),

          Expanded(
            child: GridView.builder(
              itemCount: dataIs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = dataIs[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomeWidget("Id", item.id),
                        CustomeWidget("name", item.name),
                        CustomeWidget("year", item.modelData.year),
                        CustomeWidget("price", item.modelData.price),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            floatingButton();
          }),
    );
  }
}


Widget CustomeWidget(String name , String Item){
  return Row(
    spacing: 20,
    children: [
      Text("$name : ",style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
      Expanded(child: Text(Item,style: TextStyle(fontWeight: FontWeight.w400),)),
    ],
  );
}