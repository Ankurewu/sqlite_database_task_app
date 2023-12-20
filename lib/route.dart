

import 'package:flutter/material.dart';

class PageRouting{
  static goToNextPage({ required BuildContext context, required Widget naviagteTo}){
    return Navigator.of(context).push(
MaterialPageRoute(builder: (context)=> naviagteTo),
    );
  }
}