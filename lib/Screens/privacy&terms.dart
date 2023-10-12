import 'package:flutter/material.dart';
import 'package:moneymanagementapp/Screens/accounts.dart';



class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool ischecked = false;
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
                  padding: const EdgeInsets.only(bottom: 120),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:const  Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(
                  width: 120,
                ),
                const Text(
                  'Privacy & terms',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const Text(
                'Privacy & terms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Text(
                '''  Introduction:
              
   Welcome to  Money Management App! This Privacy Policy explains how we collect, use, disclose, and protect your personal information.


   Cookies and Tracking:
   We use cookies and similar technologies to improve your experience. You can manage your cookie preferences in your browser settings.


   Policy Changes:

   We may update this Privacy Policy to reflect changes in our practices. You'll be notified of any significant changes.

  Contact Information:

  If you have questions or concerns about this policy, please contact us at sayedsinan7@gmail.com.

  Terms of Service:

  Introduction:

  Welcome to  Money Management App! By using our app, you agree to these Terms of Service.

  Acceptance of Terms:

  You agree to comply with these terms and conditions. If you don't agree, please don't use our app.

  User Accounts:

  You must register for an account and provide accurate information.
  We reserve the right to terminate or suspend accounts for violations of these terms.
 Payment and Billing:

  You are responsible for any fees associated with our services.
  Billing cycles and payment methods will be explained in the app.
  Intellectual Property:

  Our app's content is protected by copyright.
  You retain ownership of your user-generated content.
  User Conduct:

  You agree to use the app responsibly and not engage in prohibited activities [list prohibited activities].
  Liability and Disclaimers:

  We are not liable for any damages or losses.
  Our app is provided "as is" without warranties.
  Privacy and Data:

  Your use of the app is also governed by our Privacy Policy.
  We handle your data as described in that policy.
  Termination:

  We may terminate your access to the app for various reasons .
  Governing Law and Dispute Resolution:

  These terms are governed by [choose governing law].
  Any disputes will be resolved through [choose dispute resolution mechanism].
  Changes to Terms:

  We may update these terms, and you'll be notified of significant changes.
  Contact Information:
  If you have questions or need support, please contact us at Sayedsinan7@gmail.com.''',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    child: Checkbox(
                        value: ischecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            ischecked = newValue ?? false;
                          });
                        }),
                  ),
                  const Text(
                      'I, Agree on the above mentioned Terms and condition')
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Account()));
                },
                child: ClipRRect(borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 30,
                      width: 60,
                      color:const Color(0xff368983),
                      child:const Center(
                          child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
