import 'package:flutter/material.dart';
import 'package:flutter_application_1/camera_details.dart';
import 'package:flutter_application_1/locationdetails.dart';
import 'package:flutter_application_1/qrscreendetails.dart';
import 'package:flutter_application_1/route.dart';
import 'package:flutter_application_1/sql_details/sqlitescreen.dart';
import 'package:flutter_application_1/todoscreen.dart';

class FiveScreen extends StatelessWidget {
  const FiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      OpenCameraScreen(),
      QRScannerScreen(),
      LocationScreen(),
      ToDoScreen(),
      Sqlitescreen(),
      //JsonParser(),
    ];

    final List<String> screenName = [
      'Open Camera',
      'QR Scanner',
      'Location',
      'To do with HIVE',
      'To do with SQLITE',
      //'JSON Parser',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select An Option", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[400],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        itemCount: screen.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  minVerticalPadding: 20,
                  onTap: () {
                    PageRouting.goToNextPage(context: context, naviagteTo: screen[index]);
                  },
                  trailing: const Icon(Icons.forward),
                  title: Text(screenName[index].toString()),
                ),
              ),
              SizedBox(height: 10), 
            ],
          );
        },
      ),
    );
  }
}
