import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_warisan/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreWarisan {
  static final storage = FirebaseFirestore.instance;

  // Fitur Ketua
  Stream list_anggota(String id) {
    return storage
        .collection("group")
        .where("id_ketua", isEqualTo: id)
        .snapshots();
  }

  Future<String> absenUserGroup(String id, Map<String, dynamic> absen) async {
    try {
      await storage.collection("group").doc(id).delete();
      await storage.collection("absen").add(absen);
      print("Success");
      return "Success";
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

  Future<String> deleteUser(String id) async {
    try {
      await storage.collection("group").doc(id).delete();
      return "Success";
    } catch (error) {
      return error.code;
    }
  }

  Future<String> resetAbsen() async {
    try{
      QuerySnapshot data = await storage.collection("absen").get();
      data.docs.forEach((item) async {
        await storage.collection("group").add({
          "id_anggota": item["id_anggota"],
          "id_ketua" : item["id_ketua"],
          "nama" : item["nama"],
        });

        await storage.collection("absen").doc(item.id).delete();

      });

      return "Success";
    }catch(error){
      return error.code;
    }
  }

  // Fitur Anggota
  Future<String> addGroupUser(String id_ketua) async {
    try {
      await storage.collection("group").add({
        "id_anggota": AuthFirebaseControl.auth.currentUser.uid,
        "id_ketua": id_ketua,
        "nama": AuthFirebaseControl.auth.currentUser.displayName,
      });

      print("Success add group");
      return "Success";
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

  Future<List<String>> getListNameAbsen() async {
    try {
      QuerySnapshot data = await storage.collection("absen").get();

      List<String> output = List<String>(data.docs.length);
      int i = 0;
      data.docs.forEach((item) {
        output[i] = item["nama"];
        i++;
      });

      return output;
    } catch (error) {
      print(error.code);
      return error.code;
    }
  }

/*
  Future<Map<String, dynamic>> anggotaListOutput(){

  }
*/

}
