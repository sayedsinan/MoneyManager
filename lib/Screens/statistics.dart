import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Model/add_data.dart';
import 'package:moneymanagementapp/Model/utily.dart';
import 'package:moneymanagementapp/widgets/charts.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier<int> kj = ValueNotifier<int>(0);

class _StatisticsState extends State<Statistics> {
  List<String> day = ['Day', 'Week', 'Month', 'Year'];
  List<List<Add_data>> f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int indexColor = 0;

  // List of predefined categories
  List<String> predefinedCategories = [
    'food',
    "Transfer",
    "Transportation",
    "Education",
    "Add Category"
  ];

  // Helper function to get the leading widget for a category
  Widget getCategoryLeading(String categoryName) {
    if (categoryName != "Add Category" && predefinedCategories.contains(categoryName)) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/$categoryName.png', height: 40),
      );
    } else if (categoryName != "Add Category" && !predefinedCategories.contains(categoryName)) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Center(
          child: Text(
            categoryName[0], // Display the first character of the category name as a placeholder
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container(); // Handle the case when categoryName is "Add Category"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: kj,
          builder: (BuildContext context, int value, Widget? child) {
            a = f[value];
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              indexColor = index;
                              kj.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: indexColor == index
                                  ? const Color.fromARGB(255, 47, 125, 121)
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                color: indexColor == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Chart(
                indexx: indexColor,
                income: calculateIncome(a),
                expenses: calculateExpenses(a),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              String categoryName = a[index].name;

              return ListTile(
                leading: getCategoryLeading(categoryName), // Use the helper function here
                title: Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  ' ${a[index].datetime.year}-${a[index].datetime.day}-${a[index].datetime.month}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  a[index].amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: a[index].IN == 'Income' ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
            childCount: a.length,
          ),
        )
      ],
    );
  }
}
