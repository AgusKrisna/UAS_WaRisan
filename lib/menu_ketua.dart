import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_warisan/services/authentication.dart';
import 'package:uas_warisan/services/firestore.dart';
import 'package:uas_warisan/menu_ketua_joined.dart';
import 'package:uas_warisan/services/firestore.dart';
import 'show_qr.dart';
import 'spin.dart';

class Menu_Ketua extends StatefulWidget {
  @override
  _Menu_KetuaState createState() => _Menu_KetuaState();
}

class _Menu_KetuaState extends State<Menu_Ketua> {
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
            child: Transform.rotate(angle: 3.16, child: Icon(Icons.input)),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AuthFirebaseControl.auth.currentUser.displayName,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Ketua",
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Show_QR(
                              id_ketua:
                                  AuthFirebaseControl.auth.currentUser.uid)));
                },
                padding: EdgeInsets.symmetric(horizontal: 2),
                color: Colors.green[200],
                child: Text(
                  'QR Code',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: StreamKetua(),
        bottomNavigationBar: Container(
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onPressed: () async {
              
              List<String> output = await FirestoreWarisan().getListNameAbsen();
              print(output);
              
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Spin(data : output)));

            },
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            color: Colors.green[200],
            child: Text(
              'Submit Absen',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
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
                "Belum ada yang bergabung kedalam kelompok arisan Anda, silahkan tampilkan kode QR Anda kepada calon anggota.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StreamKetua extends StatelessWidget {
  StreamKetua({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreWarisan.storage.collection("group").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> rawData = snapshot.data.docs;

          if (rawData.length > 0) return MenuKetuaJoined(data: snapshot.data);
          //return Text("Text");
        }

        return EmptyScreen();
      },
    );
  }
}
