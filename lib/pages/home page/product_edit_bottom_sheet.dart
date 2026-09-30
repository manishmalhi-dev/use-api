import 'dart:convert';
import 'package:fake_api_demo_app/api%20links/api_key.dart';
import 'package:fake_api_demo_app/api%20links/api_link.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/collection_data_model.dart';

class ProductEditBottomSheet extends StatefulWidget {
  final CollectionGetData dataList;
  final String category;
  const ProductEditBottomSheet({
    super.key,
    required this.dataList,
    required this.category,
  });

  @override
  State<ProductEditBottomSheet> createState() => _ProductEditBottomSheetState();
}

class _ProductEditBottomSheetState extends State<ProductEditBottomSheet> {
  TextEditingController changeName = TextEditingController();
  TextEditingController changePrice = TextEditingController();
  TextEditingController changeYear = TextEditingController();
  final newKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addTextFieldData();
  }

  Future<void> addTextFieldData() async {
    setState(() {
      changeName.text = widget.dataList.taskName;
      changePrice.text = widget.dataList.modelData.date;
      changeYear.text = widget.dataList.modelData.optionalNotes;
    });
  }

  bool isLoading = false;
  Future<void> saveData() async {
    setState(() {
      isLoading = true;
    });
    String name = changeName.text.trim();
    String year = changeYear.text.trim();
    String price = changePrice.text.trim();
    try {
      String finalUrl = PutData.postUrl(widget.category, widget.dataList.id);

      final response = await http.put(
        Uri.parse(finalUrl),
        body: jsonEncode({
          "name": name,
          "data": {"year": year, "price": price},
        }),
        headers: {"x-api-key": ApiKey.key, "Content-Type": "application/json"},
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      // print(e);
    }
  }


  Future<void> dataPicker()async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        changeYear.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
        : Form(
            key: newKey,
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
                            "Edit Task",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Center(
                                child: Text(
                                  widget.category,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        controller: changeName,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Task";
                          }
                          return null;
                        }),
                        decoration: InputDecoration(
                          hintText: "Enter Task",
                          prefixIcon: Icon(Icons.note_add_sharp),
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
                        controller: changeYear,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select date";
                          }
                          return null;
                        },
                        onTap: (){
                          dataPicker();
                        },
                        decoration: InputDecoration(
                          hintText: "Select date",
                          prefixIcon: const Icon(Icons.calendar_month),
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
                        child: Text("Year", style: TextStyle(fontSize: 18)),
                      ),


                      TextFormField(
                        controller: changePrice,
                        maxLines: 2,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "please enter price";
                          }
                          return null;
                        }),
                        decoration: InputDecoration(
                          hintText: "Product price ",
                          prefixIcon: Icon(Icons.note_add_sharp),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (newKey.currentState!.validate()) {
                              saveData();
                            }
                          },
                          label: Text("Save Task"),
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
                          Navigator.pop(context, true);
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
