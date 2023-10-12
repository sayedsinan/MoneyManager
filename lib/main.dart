import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagementapp/Model/add_data.dart';
import 'package:moneymanagementapp/widgets/splashScreen.dart';

// import 'package:money_management_app/Screens/see_all.dart';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  Hive.openBox<String>('categories');
// 
  // final box = await Hive.openBox<Add_data>('data');
  // box.clear();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
