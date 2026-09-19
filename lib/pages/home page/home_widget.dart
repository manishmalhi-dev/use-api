import 'dart:convert';
import 'package:flutter/material.dart';
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

  // int selected =0;
  int colorIndex =0;
  bool isLoading = false;

  List<String> name = ["laptop", "phone", "tablet"];
  String categoryName = "laptop";
  List<CollectionGetData> dataIs =[];

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
                        widgetIs("name", item.name),
                        widgetIs("year", item.modelData.year),
                        widgetIs("price", item.modelData.price),
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


Widget widgetIs(String name , String item){
  return Row(
    spacing: 20,
    children: [
      Text("$name : ",style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),),
      Expanded(child: Text(item,style: TextStyle(fontWeight: FontWeight.w400),)),
    ],
  );
}