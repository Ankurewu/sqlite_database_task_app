import 'package:flutter/material.dart';
import 'package:flutter_application_1/route.dart';
import 'package:flutter_application_1/screens.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('asstes/—Pngtree—entrepreneurs plan tasks and business_7259414.png',),
            const SizedBox(height: 20),
            Text(
              'Welcome to To-Do App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Do you want to create a task fast and with ease?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PageRouting.goToNextPage(context: context, naviagteTo: FiveScreen());
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Yes"),
                  ],
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.greenAccent,
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
