import 'package:flutter/material.dart';
import 'package:uas_warisan/services/authentication.dart';
import 'package:uas_warisan/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_warisan/menu_anggota_joined.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
//import 'test_qr.dart';

class Menu_Anggota extends StatefulWidget {
  @override
  _Menu_AnggotaState createState() => _Menu_AnggotaState();
}

class _Menu_AnggotaState extends State<Menu_Anggota> {
  String _scanBarcode = 'Unknown';

  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: RaisedButton(
              onPressed: () {
                AuthFirebaseControl().signOut();
              },
              color: Colors.green[200],
              child: Transform.rotate(angle: 3.16, child: Icon(Icons.input))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AuthFirebaseControl.auth.currentUser.displayName,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Anggota",
                style: TextStyle(fontSize: 14, color: Colors.black),
              )
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 30, bottom: 10, top: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                onPressed: () async {
                  print(_scanBarcode);
                  await scanQR();
                  if (_scanBarcode != "Unknown") {
                    await FirestoreWarisan().addGroupUser(_scanBarcode);
                    setState(() {
                      _scanBarcode = "Unknown";
                    });
                  }
                  print(_scanBarcode);
                },
                padding: EdgeInsets.symmetric(horizontal: 2),
                color: Colors.green[200],
                child: Text(
                  'Join Group',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: StreamAnggota(),
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/bg.jpg"), fit: BoxFit.cover)),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Anda belum tergabung ke dalam group arisan. Silahkan bergabung dahulu melalui tombol \"Join Group\" dan melakukan scan code QR yang dimiliki oleh ketua kelompok arisan.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StreamAnggota extends StatelessWidget {
  StreamAnggota({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreWarisan.storage.collection("group").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> rawData = snapshot.data.docs;

          if (rawData.length > 0) return MenuAnggotaJoined(data: snapshot.data);
          //return Text("Text");
        }

        return EmptyScreen();
      },
    );
  }
}
