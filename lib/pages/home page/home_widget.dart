import 'dart:convert';
import 'package:fake_api_demo_app/pages/home%20page/get_single_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../api links/api_key.dart';
import '../../api links/api_link.dart';
import '../../model class/collection_get_data.dart';
import 'home_bottom_sheet.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  int colorIndex =0;
  bool isLoading = false;
  List<String> name = ["laptop", "phone", "tablet"];
  String categoryName = "laptop";
  List<CollectionGetData> dataIs =[];


  Future<void> deleteData(String id, String obj)async{
    try{
      final link =DeletePost.DltUrl(obj, id);
      final response = await http.delete(Uri.parse(link),
        headers: {
          "x-api-key": ApiLink.link,
          "Content-Type": "application/json",
        },
      );
      if(response.statusCode==200){
        print("data can be delete successfully");
        getData();
      }
    }catch(e){
      print(e);
    }

  }


  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try{
      final response = await http.get(
        Uri.parse(AddCollection.Login(categoryName)),
        headers: {"x-api-key": ApiLink.link, "Content-Type": "application/json"},
      );
      List newResponse = jsonDecode(response.body);

      setState(() {
        dataIs = newResponse.map((item)=> CollectionGetData.fromJson(item)).toList();
        isLoading = false;
      });


    }catch(e){
      print(e);
    }
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: colorIndex==index?Colors.yellow :null,
                      foregroundColor: colorIndex==index?Colors.black :null,
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
          ),
          SizedBox(height: 20,),

          isLoading==true?Expanded(child: Center(child: CircularProgressIndicator(),)):Expanded(
            child: ListView.builder(
              itemCount: dataIs.length,
              itemBuilder: (context, index) {
                final item = dataIs[index];
                return InkWell(
                  onTap: (){
                    context.push('/GetSingleItem',extra: {
                      "id" : item.id,
                      "object": categoryName
                    });

                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widgetIs("name", item.name),
                              widgetIs("year", item.modelData.year),
                              widgetIs("price", item.modelData.price),
                            ],
                          ),
                          Column(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.blue,)),
                                IconButton(onPressed: (){
                                  deleteData(item.id, categoryName);
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                              ],
                            ),
                        ],
                      ),
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


Widget widgetIs(String name , String item){
  return Row(
    spacing: 20,
    children: [
      Text("$name : ",style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
      Text(item,style: TextStyle(fontWeight: FontWeight.w400),),
    ],
  );
}