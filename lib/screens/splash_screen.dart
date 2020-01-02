import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:projetoflutterv4/models/user_model.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  int loadTimer = 8;
  DateTime logHora = DateTime.now();
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    loadData();
    _getCurrentLocation();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: loadTimer), onDoneLoading);
  }

  onDoneLoading() async {
    try {
      print(UserModel.of(context).firebaseUser.uid.toString());
      String userLogged = UserModel.of(context).firebaseUser.uid;
      String userEmail = UserModel.of(context).firebaseUser.email;
      Firestore.instance
          .collection("logs")
          .document('horarios')
          .collection(userLogged)
          .document()
          .setData({
        "registro": DateTime.now(),
        "LAT": _currentPosition.latitude.toString(),
        "LNG": _currentPosition.longitude.toString(),
        "usuario": userEmail,
      });
    } catch (e) {
      String userLogged = 'no_user';
      String userEmail = 'no_email';
      Firestore.instance
          .collection("logs")
          .document('horarios')
          .collection(userLogged)
          .document('logs')
          .setData({
        "registro": DateTime.now(),
        "LAT": _currentPosition.latitude.toString(),
        "LNG": _currentPosition.longitude.toString(),
        "usuario": userEmail
      });
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Center(
            child: Container(
          child: FlareActor(
            'assets/flr/background.flr',
            fit: BoxFit.fitWidth,
            animation: 'Background Loop',
          ),
        ));
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/gift.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: 30.0,
                    animationDuration: loadTimer * 1000,
                    percent: 1,
                    center: Text(
                      'Carregando o App Incrível...',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.purple,
                  ),
                ),
              ],
            )),
          ],
        ))
      ],
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
