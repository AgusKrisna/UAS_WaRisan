import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_warisan/services/authentication.dart';
import 'package:uas_warisan/services/firestore.dart';
import 'spin.dart';

class MenuKetuaJoined extends StatelessWidget {
  final QuerySnapshot data;
  MenuKetuaJoined({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/bg.jpg"), fit: BoxFit.cover)),
      child: ListView.builder(
        itemCount: data.docs.length,
        itemBuilder: (context, index) {
          QueryDocumentSnapshot item = data.docs[index];

          return Card(
            child: ListTile(
              title: Text(item["nama"]),
              trailing: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    await FirestoreWarisan()
                        .absenUserGroup(item.id, item.data());
                    await FirestoreWarisan().deleteUser(item.id);
                  }),
            ),
          );
        },
      ),
    );
  }
}
