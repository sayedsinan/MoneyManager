// import 'dart:io';
// import 'dart:ui_web';;
// import 'package:image_picker/image_picker.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Screens/AddTransation.dart';
import 'package:moneymanagementapp/Screens/about.dart';
import 'package:moneymanagementapp/Screens/how_to_use.dart';
import 'package:moneymanagementapp/Screens/privacy&terms.dart';
import 'package:moneymanagementapp/widgets/splashScreen.dart';
import 'package:url_launcher/url_launcher_string.dart';

// import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void _launchYouTubeVideo() async {
    const youtubeVideoUrl = 'https://youtu.be/o3kR7mbFHAU';
    if (await canLaunchUrlString(youtubeVideoUrl)) {
      await launchUrlString(youtubeVideoUrl);
    } else {
      throw 'Could not launch $youtubeVideoUrl';
    }
  }

  Future<void> photo() async {}
  // MediaQuery Iconwidth = MediaQueryData();
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
            child: const Padding(
              padding: EdgeInsets.only(top: 120, left: 150),
              child: Text(
                'Account',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff368983),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100, top: 20),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Hello',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                            // height: 5,
                            ),
                        Text(
                          'User',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Splash()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 260,
                      // ),
                      Icon(
                        Icons.home,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  child: const Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 230,
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Icon(
                          Icons.add_circle,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  child: const Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const About()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'About us',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 230,
                      // ),
                      Icon(
                        Icons.more,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  child: const Divider(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Terms()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Text(
                          'Privacy&policy',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 160,
                      // ),
                      Icon(
                        Icons.more_horiz_rounded,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            child: const Divider(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
           onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const How(),
    ),
  );
},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    'How To Use!!!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 125,
                ),
                Icon(
                  Icons.question_mark,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
