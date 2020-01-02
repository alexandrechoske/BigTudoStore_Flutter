import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetoflutterv4/screens/category_screen.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double itemsSize = 155;

    Stream<QuerySnapshot> fireData =
        Firestore.instance.collection('home').snapshots();

    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Colors.grey,
                        height: 250,
                        width: screenWidth,
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS8Y2mCrNE7O7JKfpU-Upm62I2W4ajCBEXQ28XLZPoRsks1cEQu',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    'Descubra peças Incríveis em Zircônia!',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  Image.asset(
                    'assets/images/018-jewel.png',
                    height: 30,
                    width: 40,
                  ),
                  Spacer(),
                ],
              ),
            ),
            new StreamBuilder(
              stream: Firestore.instance.
              collection('home').
              where('especialZirc', isEqualTo: 'S').
              snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: itemsSize,
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                    width: itemsSize,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                child: Text(
                                                    '${snapshot.data.documents[position]['categoria']} '
                                                    '${snapshot.data.documents[position]['classe']} '
                                                    '${snapshot.data.documents[position]['folheado']}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13)),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        snapshot.data.documents[
                                                            position]['imag'],
                                                        height: 70,
                                                        width: 70,
                                                      )),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                            ((snapshot.data.documents[position]['valorDe'] / snapshot.data.documents[position]['valorAte'] -
                                                                            1) *
                                                                        100)
                                                                    .toStringAsFixed(
                                                                        0) +
                                                                '% \nOFF',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Text('Clique aqui e confira!'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductList()));
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Divider(
                              color: Colors.blueAccent,
                              height: 10,
                              thickness: 1,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Descubra peças Incríveis em Zircônia!',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            Image.asset(
                              'assets/images/018-jewel.png',
                              height: 30,
                              width: 40,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        height: itemsSize,
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Container(
                                    width: itemsSize,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                child: Text(
                                                    '${snapshot.data.documents[position]['categoria']} '
                                                    '${snapshot.data.documents[position]['classe']} '
                                                    '${snapshot.data.documents[position]['folheado']}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13)),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                        snapshot.data.documents[
                                                            position]['imag'],
                                                        height: 70,
                                                        width: 70,
                                                      )),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                            ((snapshot.data.documents[position]['valorDe'] / snapshot.data.documents[position]['valorAte'] -
                                                                            1) *
                                                                        100)
                                                                    .toStringAsFixed(
                                                                        0) +
                                                                '% \nOFF',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20)),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Text('Clique aqui e confira!'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductList()));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          child: Divider(
                            color: Colors.blueAccent,
                            height: 10,
                            thickness: 1,
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
