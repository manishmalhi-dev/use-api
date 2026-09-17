import 'package:flutter/material.dart';

class TopCategory extends StatefulWidget {
  const TopCategory({super.key, required this.onNameSelected});

  final Function(int) onNameSelected;

  @override
  State<TopCategory> createState() => _TopCategoryState();
}

class _TopCategoryState extends State<TopCategory> {
  int colorIndex =0;

  List<String> name = ["Phones", "Laptops", "Tablets"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              widget.onNameSelected(index);
              setState(() {
                colorIndex = index;
              });
            },
            child: Text(name[index]),
          );
        },
      ),
    );
  }
}

