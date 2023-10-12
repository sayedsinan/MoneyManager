

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moneymanagementapp/widgets/BottomNavigation.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // Start the navigation process
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3)); 
    
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Bottom(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  const  Scaffold(
      backgroundColor:  Color(0xFF2BAD9E),
      body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding:  EdgeInsets.only(left: 50, top: 350),
            // child: Icon(
            //   Icons.money_outlined,
            //   size: 50,
            // ),
          // ),
          SizedBox(height: 10),
          Padding(
            padding:  EdgeInsets.only(left: 40, top: 400),
            child: Text(
              'Money Management App',
              style: TextStyle(color: Colors.white, fontSize: 30, fontStyle: FontStyle.normal),
            ),
          ),
        ],
      ),
    );
  }
}
