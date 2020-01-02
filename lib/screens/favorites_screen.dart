import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> fireData = Firestore.instance
        .collection('favorites').snapshots();

    return Container(
        child:
        StreamBuilder(
            stream: fireData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListTile(
                title: Text(snapshot.data.documents.length.toString()),

                //TODO: TERMINAR TELA FAVORITOS

              );
            }
        )
    );
  }
}