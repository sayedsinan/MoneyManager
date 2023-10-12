import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Screens/AddTransation.dart';


class CategoryIcon extends StatefulWidget {
  final String categoryName;

  CategoryIcon(this.categoryName);

  @override
  _CategoryIconState createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  @override
  Widget build(BuildContext context) {
    if (widget.categoryName != "Add Category" && item.contains(widget.categoryName)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${widget.categoryName}.png', height: 40, width: 40),
      );
    } else {
      return Container(
        width: 40,
        height: 40, // Adjust the image container size
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey, // Placeholder color for non-user-defined categories
        ),
        child: Center(
          child: Text(
            widget.categoryName[0], // Display the first character of the category name as a placeholder
            style:const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
