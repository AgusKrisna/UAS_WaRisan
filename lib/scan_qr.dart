import 'package:flutter/material.dart';

class Scan_QR extends StatefulWidget {
  @override
  _Scan_QRState createState() => _Scan_QRState();
}

class _Scan_QRState extends State<Scan_QR> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 40,
            ),
            title: Text(
              "Scan QR Code",
              style: TextStyle(color: Colors.black),
            ),
            actions: [],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/bg.jpg"), fit: BoxFit.cover)),
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 250,
                        width: 250,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Silahkan arahkan kamera tepat pada posisi QR Code dari Ketua",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
