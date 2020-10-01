import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scanit/ui/firstS.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BarCode(),
      theme: ThemeData(
          primaryColor: Hexcolor('#F9F9F9')
  )
  )
  );
}