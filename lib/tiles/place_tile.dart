import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projetoflutterv4/screens/feedback_form.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 350.0,
              child: Image.network(
                snapshot.data["image"],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      snapshot.data["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      snapshot.data["description"],
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: RawMaterialButton(
                          onPressed: () {
                            launch("tel:${snapshot.data["phone"]}");
                          },
                          child:
                              Icon(Icons.phone, size: 25, color: Colors.black),
                          shape: new CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                    ],
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      FlutterOpenWhatsapp.sendSingleMessage("41996194300",
                          "Olá! Estou no aplicativo e gostaria de mais informações :)");
                    },
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS8bZHsjU8Ab8Zhss-fvin2aEdF5xYeGeor8gr92rKZB-2r2sdm',
                      height: 25,
                      width: 25,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => FeedBackScreen()));
                    },
                    child: Icon(Icons.feedback, size: 25, color: Colors.black),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
