import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class How extends StatelessWidget {
  const How({Key? key});

  // Function to launch the YouTube video URL
  void _launchYouTubeVideo() async {
    const youtubeVideoUrl = 'https://youtu.be/o3kR7mbFHAU';
    if (await canLaunchUrlString(youtubeVideoUrl)) {
      await launchUrlString(youtubeVideoUrl);
    } else {
      throw 'Could not launch $youtubeVideoUrl';
    }
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
                    padding: const EdgeInsets.only(bottom: 50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:const  Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const   SizedBox(
                    width: 130,
                  ),
                const   Text(
                    'How To Use',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const  Text(
                    'Welcome to the App!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(height: 10),
              const     Text(
                    'Here is a quick guide on how to use the app:',
                    style: TextStyle(fontSize: 16),
                  ),
               const    SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style:const  TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                      const   TextSpan(
                          text: 'Enjoy using the app and managing your finances! ',
                        ),
                        TextSpan(
                          text: 'Watch a tutorial video on YouTube',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchYouTubeVideo();
                            },
                        ),
                       const  TextSpan(
                          text: ' or visit the video here: ',
                        ),
                        TextSpan(
                          text: 'https://youtu.be/o3kR7mbFHAU',
                          style:const  TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrlString('https://youtu.be/o3kR7mbFHAU');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
