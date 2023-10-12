import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanagementapp/Model/add_data.dart';
import 'package:moneymanagementapp/Model/editing.dart';
import 'package:moneymanagementapp/Screens/AddTransation.dart';
import 'package:moneymanagementapp/widgets/catogery_Icon.dart';


class Transcation extends StatefulWidget {
  const Transcation({super.key});

  @override
  State<Transcation> createState() => _TranscationState();
}

final List<String> day = [
  'Monday',
  "Tuesday",
  "Wednesday",
  "Thursday",
  'Friday',
  'Saturday',
  'Sunday'
];

class _TranscationState extends State<Transcation> {
  final TextEditingController _searchController = TextEditingController();
  List<Add_data> searchResult = [];
  final Box<Add_data> box = Hive.box<Add_data>('data');
  String? selectedOption;
  final Map<String, Widget> categoryLeadingWidgets = {};
  @override
  void initState() {
    super.initState();
    // Populate the searchResult list with all data initially
    searchResult = box.values.toList();

    _searchController.addListener(() {
      _search();
    });
  }

  void _search() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      searchResult = box.values
          .where((data) =>
              data.name.toLowerCase().contains(query) ||
              data.explain.toLowerCase().contains(query))
          .toList();

      // Apply filtering based on the selected radio button
      if (selectedOption == 'all') {
        // No additional filtering for 'all'
      } else if (selectedOption == 'income') {
        searchResult =
            searchResult.where((data) => data.IN == 'Income').toList();
      } else if (selectedOption == 'expense') {
        searchResult =
            searchResult.where((data) => data.IN == 'Expense').toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 43),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Transaction History',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 25,
                  ),
                  Radio<String>(
                    value: 'all',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                        _search();
                      });
                    },
                  ),
                  const Text('All'),
                  const SizedBox(
                    width: 25,
                  ),
                  Radio<String>(
                    value: 'income',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        if (selectedOption == value) {
                          selectedOption = null;
                        } else {
                          selectedOption = value;
                        }
                        _search();
                      });
                    },
                  ),
                  const Text('Income'),
                  const SizedBox(
                    width: 40,
                  ),
                  Radio<String>(
                    value: 'expense',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        if (selectedOption == value) {
                          selectedOption = null;
                        } else {
                          selectedOption = value;
                        }
                        _search();
                      });
                    },
                  ),
                  const Text('Expense'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Transaction History',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Display added data here
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResult.length,
              itemBuilder: (BuildContext context, int index) {
                final history = searchResult[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      history.delete();
                    } else if (direction == DismissDirection.endToStart) {
                      openEditDialog(context, history);
                    }
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CategoryIcon(
                        history.name), // Use CategoryIcon widget here
                    title: Text(
                      history.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      history.amount,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color:
                            history.IN == 'Income' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget getCategoryLeading(String categoryName) {
    if (categoryName != "Add Category" && item.contains(categoryName)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/$categoryName.png', height: 40, width: 40),
      );
    } else if (categoryName != "Add Category" && !item.contains(categoryName)) {
      if (categoryLeadingWidgets.containsKey(categoryName)) {
        return categoryLeadingWidgets[categoryName]!;
      } else {
        final Widget leadingWidget = Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              categoryName[0],
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
        categoryLeadingWidgets[categoryName] = leadingWidget;
        return leadingWidget;
      }
    } else {
      return Container();
    }
  }
}
