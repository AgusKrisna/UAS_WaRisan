import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_warisan/services/firestore.dart';

class AuthFirebaseControl {
  static final auth = FirebaseAuth.instance;
  final CollectionReference _user_table =
      FirebaseFirestore.instance.collection('users');

  Stream<User> get getUserState {
    return auth.authStateChanges();
  }

  Future<String> get getUserLevel async {
    try {
      String currentUid = auth.currentUser.uid;

      String output;

      await _user_table
          .where("source_UID", isEqualTo: currentUid)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((data) {
          output = data["level"].toString();
        });
      });

      return output;
    } catch (error) {

      return error.message;
    }
  }

  Future<String> signUp(String username, String email, String password,
      String level) async {
    try {
      UserCredential data = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      User user = data.user;
      user.updateProfile(displayName: username);

      _user_table.add({
        "source_UID": auth.currentUser.uid, 
        "level": level,
      }); 

      return "Success";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Success";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();

      return null;
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }
}
