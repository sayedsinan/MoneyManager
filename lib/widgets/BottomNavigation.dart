
import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Screens/AddTransation.dart';
import 'package:moneymanagementapp/Screens/accounts.dart';
import 'package:moneymanagementapp/Screens/homePage.dart';
import 'package:moneymanagementapp/Screens/statistics.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int indexColor = 0;
  List screen = [const Home(),const Statistics(), const Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor:const  Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 70,
        child: BottomAppBar(
          shape:const  CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 0;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Icon(
                      Icons.home,
                      size: 30,
                      color: indexColor == 0 ?const Color(0xff368983) : Colors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70,top: 25),
                    child: Icon(
                      Icons.bar_chart_outlined,
                      size: 30,
                      color: indexColor == 1 ?const Color(0xff368983) : Colors.grey,
                    ),
                  ),
                ),
              const   SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 2;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Icon(
                      Icons.blur_circular,
                      size: 30,
                      color: indexColor == 2 ?const Color(0xff368983) : Colors.grey,
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

