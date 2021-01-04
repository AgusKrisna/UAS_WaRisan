import 'package:flutter/material.dart';
import 'package:uas_warisan/menu_ketua_joined.dart';
import 'package:uas_warisan/menu_anggota_joined.dart';
import 'login.dart';
import 'menu_anggota.dart';
import 'menu_ketua.dart';
// firebase service
import 'package:firebase_core/firebase_core.dart';
import 'package:uas_warisan/services/authentication.dart';
import 'package:uas_warisan/services/firestore.dart';

GlobalKey<NavigatorState> navigator_key = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialAppWarisan());
}
/*
void main() {
  runApp(MaterialAppWarisan());
}
*/
class StreamAuthStateChanges extends StatelessWidget {
  //String userLevel;

  StreamAuthStateChanges({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthFirebaseControl().getUserState,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if(snapshot.hasData){

          /*
          userLevelCheck();
          if (userLevel == "ketua"){
            return Menu_Ketua();
          }
          return Menu_Anggota();
          */ 
          return CheckUserLevel();
          //return Menu_Ketua();
        }
        return Login();
      },
    );
  }
}

class CheckUserLevel extends StatelessWidget {
  const CheckUserLevel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthFirebaseControl().getUserLevel,
      builder: (context, snapshot){
      //AuthFirebaseControl.auth.signOut();
        if(snapshot.data == "ketua"){
          return Menu_Ketua();
        }

        if (snapshot.data == "anggota"){
          return Menu_Anggota();
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class MaterialAppWarisan extends StatelessWidget {
  const MaterialAppWarisan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        navigatorKey: navigator_key,
        theme: ThemeData.light(),
        //routes:
       home: StreamAuthStateChanges(),
      ),
    );
  }
}
