import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Show_QR extends StatefulWidget {
  final String id_ketua;
  Show_QR({this.id_ketua});
  @override
  _Show_QRState createState() => _Show_QRState(id_ketua: this.id_ketua);
}

class _Show_QRState extends State<Show_QR> {
  final String id_ketua;
  _Show_QRState({this.id_ketua});
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
              "Show QR Code $id_ketua",
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
                      QrImage(
                        data: this.id_ketua,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Silahkan berikan QR Code ini kepada calon anggota",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
