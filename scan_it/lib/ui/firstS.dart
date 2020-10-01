import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/services.dart';

class BarCode extends StatefulWidget {
  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {

  var result = "Hello user! How's it going? ";

  Future _ScanBar() async {
    try {
      ScanResult  qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Please allow ScanIt to use Camera.";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything. Try scanning again!";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Hexcolor('#8C30EA'),
        title: Text("ScanIt",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Hexcolor('#F9F9F9')
          ),),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Hexcolor('#8C30EA'),
        tooltip: 'Press to Scan',
        onPressed:_ScanBar
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Text("$result" ,
        style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        )
      ),
    );
  }
}