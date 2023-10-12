// ignore_for_file: sort_child_properties_last

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneymanagementapp/Model/add_data.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({Key? key});

  @override
  State<AddScreen> createState() => _addScreenState();
}

final TextEditingController newCategoryController = TextEditingController();
XFile? image;
List<String> item = [
  'food',
  "Transfer",
  "Transportation",
  "Education",
  "Add Category"
];

final List<String> _itemei = [
  'Income',
  "Expense",
];
Widget buildCategoryDropdown(
    String? selectedCategory, ValueChanged<String?> onChanged) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 2,
        color: const Color(0xffC5C5C5),
      ),
    ),
    child: DropdownButton<String>(
      value: selectedCategory,
      onChanged: onChanged,
      items: item.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Row(
            children: [
              if (e != "Add Category" && item.contains(e))
                Container(
                  width: 40,
                  child: Image.asset('images/${e}.png'),
                ),
              if (e != "Add Category" && !item.contains(e))
                Container(
                  width: 40,
                  height: 40, // Adjust the image container size
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                        .grey, // Placeholder color for non-user-defined categories
                  ),
                  child: Center(
                    child: Text(
                      e[0], // Display the first character of the category name as a placeholder
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                e,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      }).toList(),
      hint: const Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          'Category',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      dropdownColor: Colors.white,
      isExpanded: true,
      underline: Container(),
    ),
  );
}

Widget buildIncomeOrExpense(
    String? selectedHow, ValueChanged<String?> onhow) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 2,
        color: const Color(0xffC5C5C5),
      ),
    ),
    child: DropdownButton<String>(
      value: selectedHow,
      onChanged: onhow,
      items: _itemei.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Row(
            children: [
              if (e != "Add Category" && item.contains(e))
                Container(
                  width: 40,
                  child: Image.asset('images/${e}.png'),
                ),
              if (e != "Add Category" && !item.contains(e))
                Container(
                  width: 40,
                  height: 40, // Adjust the image container size
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                        .grey, // Placeholder color for non-user-defined categories
                  ),
                  child: Center(
                    child: Text(
                      e[0], // Display the first character of the category name as a placeholder
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Text(
                e,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      }).toList(),
      hint: const Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          'Category',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      dropdownColor: Colors.white,
      isExpanded: true,
      underline: Container(),
    ),
  );
}

Future<void> _showAddCategoryDialog(BuildContext context) async {
  bool isUserDefinedCategory = true; // Track if the category is user-defined

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isUserDefinedCategory) // Only show image for user-defined category
              TextField(
                controller: newCategoryController,
                decoration:
                    const InputDecoration(hintText: 'Enter Category Name'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              String newCategory = newCategoryController.text;
              if (newCategory.isNotEmpty) {
                isUserDefinedCategory = item.indexOf(newCategory) == -1;
                await Hive.box<String>('categories').add(newCategory);

                item.add(newCategory);

                // Close the dialog
                Navigator.of(context).pop();
                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Category "$newCategory" added.'),
                    backgroundColor: const Color(0xff368983),
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

class _addScreenState extends State<AddScreen> {
  final box = Hive.box<Add_data>('data');
  DateTime date = DateTime.now();
  String? selectedCategory;
  String? selectedType;
  final TextEditingController explainController = TextEditingController();
  FocusNode explainFocus = FocusNode();
  final TextEditingController amountController = TextEditingController();
  FocusNode amountFocus = FocusNode();

  List<String> predefinedCategories = [
    'food',
    "Transfer",
    "Transportation",
    "Education",
    "Add Category"
  ];

  @override
  void initState() {
    super.initState();
    // Initialize Hive and get categories
    Hive.openBox<String>('categories').then(
      (categoryBox) {
        setState(
          () {
            // Merge the predefined list and the categories from Hive
            item = [...predefinedCategories, ...categoryBox.values.toList()];
            // Check if "Add Category" is already in the list before adding it
            if (!item.contains("Add Category")) {
              item.add("Add Category");
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgorundContainer(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          const SizedBox(height: 50),
          name(),
          const SizedBox(height: 30),
          explain(),
          const SizedBox(height: 30),
          amount(),
          const SizedBox(height: 30),
          How(),
          const SizedBox(height: 30),
          date_time(),
          const Spacer(),
          save(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        var add = Add_data(
          selectedType!,
          amountController.text,
          date,
          explainController.text,
          selectedCategory!,
        );
        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff368983),
        ),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget date_time() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: const Text(
          'Date : Day / Month / Year',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedType,
          onChanged: ((value) {
            setState(() {
              selectedType = value!;
            });
          }),
          items: _itemei
              .map((e) => DropdownMenuItem(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _itemei
              .map((e) => Row(
                    children: [Text(e)],
                  ))
              .toList(),
          hint: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'How',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amountFocus,
        controller: amountController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        focusNode: explainFocus,
        controller: explainController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Description',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedCategory,
          onChanged: ((value) {
            setState(() {
              selectedCategory = value!;
              if (value == "Add Category") {
                // Show the Add Category dialog
                _showAddCategoryDialog(context);
              }
            });
          }),
          items: item.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Row(
                children: [
                  if (e != "Add Category" && predefinedCategories.contains(e))
                    Container(
                      width: 40,
                      child: Image.asset('images/${e}.png'),
                    ),
                  if (e != "Add Category" && !predefinedCategories.contains(e))
                    Container(
                      width: 40,
                      height: 40, // Adjust the image container size
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .grey, // Placeholder color for non-user-defined categories
                      ),
                      child: Center(
                        child: Text(
                          e[0], // Display the first character of the category name as a placeholder
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Text(
                    e,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }).toList(),
          hint: const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Category',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Column backgorundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 160),
                      child: Text(
                        'Adding',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
