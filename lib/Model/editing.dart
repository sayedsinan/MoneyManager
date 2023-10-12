import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Model/add_data.dart';
import 'package:moneymanagementapp/Model/utily.dart';
import 'package:moneymanagementapp/Screens/AddTransation.dart';

class EditDataDialog extends StatefulWidget {
  final Add_data existingData;

  EditDataDialog({required this.existingData});

  @override
  _EditDataDialogState createState() => _EditDataDialogState();
}

class _EditDataDialogState extends State<EditDataDialog> {
  TextEditingController explainController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String? selectedCategory;
  String? selectedHow;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers and selected values with existing data
    explainController.text = widget.existingData.explain;
    amountController.text = widget.existingData.amount;
    selectedCategory = widget.existingData.category;
    selectedHow = widget.existingData.IN;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Data"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildCategoryDropdown(
              selectedCategory,
              (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
            TextField(
              controller: explainController,
              decoration: const InputDecoration(labelText: 'Explanation'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            buildIncomeOrExpense(selectedHow, (String? newhow) {
              setState(() {
                selectedHow = newhow;
              });
            })
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            // Do nothing when Cancel is pressed
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            String newExplain = explainController.text;
            String newAmount = amountController.text;

            // Update the data with the selected category and income/expense
            editData(
              widget.existingData,
              selectedCategory!,
              newExplain,
              newAmount,
              selectedHow!,
              DateTime.now(),
            );

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class EditDataDialogWrapper extends StatefulWidget {
  final Add_data existingData;

  EditDataDialogWrapper({required this.existingData});

  @override
  _EditDataDialogWrapperState createState() => _EditDataDialogWrapperState();
}

class _EditDataDialogWrapperState extends State<EditDataDialogWrapper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the EditDataDialog when tapped on the widget
        openEditDialog(context, widget.existingData);
      },
      child: Text(
        widget.existingData.explain, // Display existing data
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
    );
  }
}

void openEditDialog(BuildContext context, Add_data existingData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditDataDialog(existingData: existingData);
    },
  );
}
