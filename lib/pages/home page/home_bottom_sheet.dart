import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/api%20links/api_link.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeBottomSheet extends StatefulWidget {
  final String selectedCategory;
  const HomeBottomSheet({super.key, required this.selectedCategory});

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController year = TextEditingController();

  late String collectionsName;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      collectionsName = widget.selectedCategory;
      final today = DateTime.now();
      price.text = "${today.day}/${today.month}/${today.year}";
    });
  }

  List<String> buttonSelected = ["Work", "Personal", "Study"];
  List<Icon> categoryIcons =[Icon(Icons.work), Icon(Icons.person), Icon(Icons.school)];
  Future<void> postData() async {
    String finalName = name.text.trim();
    String finalPrice = price.text.trim();
    String finalYear = year.text.trim()??" ";

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse(AddCollection.Login(collectionsName)),
        body: jsonEncode({
          "name": finalName,
          "data": {"year": finalYear, "price": finalPrice},
        }),
        headers: {"Content-Type": "application/json", "x-api-key": ApiKey.key},
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        name.clear();
        price.clear();
        year.clear();
        if (mounted) {
          // Navigator.pop(context, true,);
          Navigator.pop(context, {
            "confirm": true,
            "category": collectionsName,
          },);
        }
      } else {}
    } catch (e) {
      // print(e);
    }
  }

  bool isLoading = false;

  Future<void> dataPicker()async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        price.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator()),
          )
        : SingleChildScrollView(
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
                              "Add Task",
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
                            "Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    collectionsName = buttonSelected[index];
                                  });
                                },
                                label: Row(
                                  children: [
                                    Text(buttonSelected[index]),
                                    SizedBox(width: 7,),
                                   categoryIcons[index],
                                  ],
                                ),
                                icon: collectionsName == buttonSelected[index]?Icon(Icons.check):null,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  foregroundColor: collectionsName == buttonSelected[index] ? Colors.black : Colors.white,
                                  backgroundColor: collectionsName == buttonSelected[index] ? Colors.yellow : Colors.grey,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                            itemCount: buttonSelected.length,
                          ),
                        ),

                        SizedBox(height: 10),
                        TextFormField(
                          controller: name,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "please enter name";
                            }
                            return null;
                          }),
                          decoration: InputDecoration(
                            hintText: "What needs to be done?",
                            prefixIcon: Icon(Icons.task),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Due Date", style: TextStyle(fontSize: 16)),
                        ),


                        TextFormField(
                          controller: price,
                          readOnly: true,
                          onTap: () async {
                            dataPicker();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select date";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Select date",
                            prefixIcon: const Icon(Icons.calendar_month),
                            suffixIcon: IconButton(
                              onPressed: () {
                                price.clear();
                              },
                              icon: const Icon(Icons.close),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),


                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Add Note", style: TextStyle(fontSize: 18)),
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: year,
                          decoration: InputDecoration(
                            hintText: "Add Note (Optional)",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                postData();
                              }
                            },
                            label: Text("Add Task"),
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
