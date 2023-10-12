
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding:const  EdgeInsets.only(right: 0, bottom: 60),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:const  Icon(Icons.arrow_back)),
                   const  Padding(
                      padding:  EdgeInsets.only(left: 100, top: 50),
                      child: Text(
                        'About us',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.money_rounded,
                  size: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Text(
                  'This is an app that is developed as part of my project and this will be one of my greatest milstone in my career this is an money managemnet app which wiil be useful for many people for those who have a bad  habit of spending money and they will be able to be on track of how to manage their money managemnet .',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
