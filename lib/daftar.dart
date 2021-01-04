import 'package:flutter/material.dart';
import 'package:uas_warisan/main.dart';
import 'package:uas_warisan/login.dart';
import 'package:uas_warisan/menu_anggota.dart';
import 'package:uas_warisan/menu_ketua_joined.dart';
import 'package:uas_warisan/services/authentication.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  String nama;
  String username;
  String email;
  String password;
  String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/bg.jpg"), fit: BoxFit.cover)),
          child: ListView(
            children: <Widget>[
              Container(
                padding:
                EdgeInsets.only(top: 60, left: 40, right: 40, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "DAFTAR",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 40,
                    ), 
                    Text(
                      "Username",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white),
                      onChanged: (value){
                        username = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white),
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          filled: true, fillColor: Colors.white),
                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Daftar Sebagai",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            onPressed: (){
                              setState(() {
                                level = 'ketua';
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            color: Colors.green[200],
                            child: Text(
                              'Ketua',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            onPressed: () {
                              setState(() {
                                level = 'anggota';
                              });
                            },
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.green[200],
                            child: Text(
                              'Anggota',
                              style:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () async {
                          String output = await AuthFirebaseControl().signUp(username, email, password, level);
                          
                          if(output == "Success"){
                            navigator_key.currentState.pop();
                          }

                        },
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        color: Colors.green[200],
                        child: Text(
                          'Daftar',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 1,
                      width: 250,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      width: 200,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Sudah punya akun ?"),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        color: Colors.green[200],
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
