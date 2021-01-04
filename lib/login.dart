import 'package:flutter/material.dart';
import 'package:uas_warisan/daftar.dart';
import 'package:uas_warisan/services/authentication.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;

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
                padding: EdgeInsets.only(top: 60, left: 40, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOG IN",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Email",
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Password",
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        color: Colors.green[200],
                        child: Text("Login",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        onPressed: () async {

                          String output = await AuthFirebaseControl().signIn(username, password);
                          print(output);
                          

                        },
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
                    Text("Tidak punya akun ?"),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        onPressed: () {
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Daftar()));
                          
                          //AuthFirebaseControl().signIn(username, password);
                        },
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        color: Colors.green[200],
                        child: Text(
                          'Daftar',
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
