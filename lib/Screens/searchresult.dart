import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Model/add_data.dart';

class Result extends StatefulWidget {
  final List<Add_data> searchResult; // Pass the search results as a parameter

  const Result({required this.searchResult, Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: 200,
            height: 200,
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
                  padding: const EdgeInsets.only(bottom: 100),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(
                  width: 100,
                ),
                const Text(
                  'Search Result',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.searchResult.length,
            itemBuilder: (context, index) {
              final result = widget.searchResult[index];
              return ListTile(
                title: Text(result.name),
                subtitle: Text(result.explain),
                trailing: Text(result.amount),
                leading: Text(result.datetime.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
