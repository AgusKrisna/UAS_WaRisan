import 'package:flutter/material.dart';
import 'spin.dart';
import 'show_qr.dart';

class Menu_Ketua_Joined extends StatefulWidget {
  @override
  _Menu_Ketua_JoinedState createState() => _Menu_Ketua_JoinedState();
}

class _Menu_Ketua_JoinedState extends State<Menu_Ketua_Joined> {
  //boolean checkbox
  bool valuecheck;
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Show_QR()));
                },
                color: Colors.green[200],
                child: Icon(Icons.backspace)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Nama Ketua",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Show_QR()));
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
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/bg.jpg"), fit: BoxFit.cover)),
              child: ListView(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            //
                            //
                            //
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: 250,
                                  child: Text("Anggota 1"),
                                ),
                                Container(
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      value: valuecheck,
                                      onChanged: (bool value) {
                                        setState(() {
                                          valuecheck = value;
                                        });
                                      }),
                                ),
                                Container(
                                  width: 60,
                                  child: FlatButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    child: Icon(Icons.delete_outline),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: 250,
                                  child: Text("Ibu Ayam saya mati"),
                                ),
                                Container(
                                  child:
                                      Checkbox(value: false, onChanged: null),
                                ),
                                Container(
                                  width: 60,
                                  child: FlatButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    child: Icon(Icons.delete_outline),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        //
                        //
                        //
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Spin()));
                          },
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.green[200],
                          child: Text(
                            'Submit Absen',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
