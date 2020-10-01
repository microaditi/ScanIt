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
  var result = "Hey AJ ";

  Future _ScanBar() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
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
        backgroundColor: Hexcolor(
          '#8C30EA',
        ),
        title: Text(
          "MY CART - Landing screen",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Hexcolor(
                '#F9F9F9',
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        child: Icon(
          Icons.add,
          semanticLabel: "Scan button",
        ),
        backgroundColor: Hexcolor(
          '#8C30EA',
        ),
        tooltip: 'Press to Scan',
        onPressed: _ScanBar,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Text(
          "$result",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
