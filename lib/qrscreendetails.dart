import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String _scanbarcodeResult = "";
   String scannerName = "";
  

  Future<void> scanbarcodenormal() async {
    // String barcodeScanner;
    try {
      _scanbarcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      setState(() {
        scannerName ='Bar Code Result:';

        // _scanbarcodeResult =QRcodeScanner;
        
      });
      debugPrint(_scanbarcodeResult);
    } on PlatformException {
      _scanbarcodeResult = 'Failed to get barcode scan result.';
      if (!mounted) return;
      setState(() {
        // _scanbarcodeResult = barcodeScanner;
      });
    }
  }
  Future<void> scanQRcode() async {
  //  late String QRcodeScanner;
    try {
      _scanbarcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
        
      );
      setState(() {
       scannerName ='Qr Code Result:';
        // _scanbarcodeResult =QRcodeScanner;
        
      });



      print(_scanbarcodeResult);
    } on PlatformException {
     _scanbarcodeResult = 'Failed to get barcode scan result.';
      if (!mounted) return;
      setState(() {
        // _scanbarcodeResult =QRcodeScanner;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR And Bar Code Scanner',style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    scanbarcodenormal();
                  },
                  child: Text("Start barcode scan"),
                ),
                SizedBox(height: 10.0,),
                ElevatedButton(
                  onPressed: () {
                    scanQRcode();
                    setState(() {
                      print(_scanbarcodeResult.toString());
                    });
                  },
                  child: Text("Start QR code scan"),
                ),
                Text("$scannerName ${_scanbarcodeResult}"),
               
              ],
            ),
          );
        },
      ),
    );
  }
}
