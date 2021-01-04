import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'package:uas_warisan/services/firestore.dart';

class Spin extends StatefulWidget {
  List<String> data;
  Spin({this.data});
  @override
  _SpinState createState() => _SpinState(listData: this.data);
}

class _SpinState extends State<Spin> {
  // index
  List<String> listData;
  int selected = 0;

  _SpinState({this.listData});

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];
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
              "Spin Undian",
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
                        child: FortuneBar(
                            selected: selected,
                            animateFirst: false,
                            items: [
                              for (var it in listData)
                                FortuneItem(child: Text(it)),
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Silahkan tekan \"Spin\" untuk melakukan undian arisan",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            setState(() {
                              selected = Random().nextInt(items.length);
                            });
                          },
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          color: Colors.green[200],
                          child: Text(
                            'Spin',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () async {
                            String output = await FirestoreWarisan().resetAbsen();
                            print(output);
                            Navigator.pop(context);

                          },
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          color: Colors.green[200],
                          child: Text(
                            'Kembali',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
