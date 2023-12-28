import 'package:flutter/material.dart';

Widget brandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text('Haze',style: TextStyle(color: Colors.black),),
      Text('S', style: TextStyle(color: Colors.green),)
    ],
  );
}