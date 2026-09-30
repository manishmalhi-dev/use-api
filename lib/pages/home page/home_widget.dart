import 'dart:convert';
import 'package:fake_api_demo_app/pages/home%20page/product_edit_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api links/api_key.dart';
import '../../api links/api_link.dart';
import '../../models/collection_data_model.dart';
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

  int colorIndex = 0;
  bool isLoading = false;
  List<String> name = ["Work", "Personal", "Study"];
  List<IconData> categoryIcons = [
    Icons.work,
    Icons.person,
    Icons.school,
  ];  String categoryName = "Work";
  List<CollectionGetData> dataIs = [];

  Future<void> deleteData(String id, String obj) async {
    try {
      final link = DeletePost.DltUrl(obj, id);
      final response = await http.delete(
        Uri.parse(link),
        headers: {"x-api-key": ApiKey.key, "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        getData();
      }
    } catch (e) {
      // print(e);
    }
  }

  List<Map<String, dynamic>> testModel = [];

  Future<void> getData() async {
    setState(() {
      // isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse(AddCollection.Login(categoryName)),
        headers: {"x-api-key": ApiKey.key, "Content-Type": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List newResponse = jsonDecode(response.body);
        setState(() {
          dataIs = newResponse
              .map((item) => CollectionGetData.fromJson(item))
              .toList();
        });
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // print(e);
    }
  }

  void floatingButton() async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return HomeBottomSheet(selectedCategory: categoryName);
      },
    );
    if (result != null && result["confirm"] == true) {
      setState(() {
        categoryName = result["category"];
      });
      getData();
    }
  }

  void dataEdit(CollectionGetData newOne, String category) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ProductEditBottomSheet(dataList: newOne, category: category);
      },
    );
    if (result == true) {
      getData();
    }
  }

  String selected = "List";

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
                  return SizedBox(width: 10);
                },
                scrollDirection: Axis.horizontal,
                itemCount: name.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        colorIndex = index;
                        categoryName = name[index];
                        dataIs.clear();
                        isLoading = true;
                      });
                      getData();
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:name[index]==categoryName?Colors.yellow:Color.fromRGBO(234, 221, 255, 1),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            if(name[index]==categoryName)Icon(Icons.check, color: Colors.black,),
                            Text(name[index], style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
                            Icon(categoryIcons[index], color: Colors.black,),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),

          isLoading == true
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: ListView.builder(
                    itemCount: dataIs.length,
                    itemBuilder: (context, index) {
                      final item = dataIs[index];
                      return TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 500),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 2,
                                  shadowColor: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          child: Icon(
                                            Icons.work_history,
                                            color: Colors.yellow.shade600,
                                            size: 22,
                                          ),
                                        ),

                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      item.taskName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // color: Color(0xff1F2937),
                                                      ),
                                                    ),
                                                  ),

                                                  Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                            15,
                                                            5,
                                                            15,
                                                            5,
                                                          ),
                                                      child: Text(
                                                        categoryName,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          // color: Colors.red.shade400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 14,
                                                    color: Colors.grey.shade500,
                                                  ),

                                                  const SizedBox(width: 4),

                                                  Text(
                                                    item
                                                        .modelData
                                                        .optionalNotes,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      // color: Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 7),
                                              Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                        10,
                                                        4,
                                                        10,
                                                        4,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          item.modelData.date,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            height: 1.3,
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(width: 5),
                                                      IconButton(
                                                        onPressed: () {
                                                          dataEdit(
                                                            dataIs[index],
                                                            categoryName,
                                                          );
                                                        },
                                                        padding: EdgeInsets.zero,
                                                        constraints: const BoxConstraints(
                                                              minWidth: 32,
                                                              minHeight: 32,
                                                            ),
                                                        icon: const Icon(
                                                          Icons.edit_outlined,
                                                          size: 18,
                                                          color: Colors.blue,
                                                        ),
                                                      ),

                                                      // Delete
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                  "Delete Item",
                                                                ),
                                                                content: const Text(
                                                                  "Are you sure you want to delete this item?",
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                      "Cancel",
                                                                    ),
                                                                  ),

                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      deleteData(
                                                                        item.id,
                                                                        categoryName,
                                                                      );

                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    child: const Text(
                                                                      "Delete",
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            const BoxConstraints(
                                                              minWidth: 32,
                                                              minHeight: 32,
                                                            ),
                                                        icon: const Icon(
                                                          Icons.delete_outline,
                                                          size: 19,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          floatingButton();
        },
      ),
    );
  }
}
