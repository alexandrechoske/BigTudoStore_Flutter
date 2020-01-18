import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetoflutterv4/screens/product_screen.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductList createState() => new _ProductList();
}

class _ProductList extends State<ProductList> {
  int varButton = 1;
  String fCategoria;
  String fClasse;
  bool isAdultoSelected = false;
  bool isInfantilSelected = false;
  String fFolheado;
  bool isOuroSelected = false;
  bool isPrataSelected = false;
  bool isCouroSelected = false;

  final databaseReference =
      Firestore.instance.collection('bdralifla').reference();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> fireData = Firestore.instance
        .collection('bdralifla')
        .where('categoria', isEqualTo: fCategoria)
        .where('classe', isEqualTo: fClasse)
        .where('folheado', isEqualTo: fFolheado)
        .orderBy('valorAte', descending: true)
        .snapshots();

    Color filterColor = Colors.white30;

    return new Container(
      child: Scaffold(
        body: StreamBuilder(
          stream: fireData,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data.documents.map((snapshot) {
                return new Card(
                  elevation: 5,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/gifs/spinner2.gif',
                            image: snapshot['imag'] != null
                                ? snapshot['imag']
                                : '',
                          ),
                        )),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(snapshot['especialZirc'] == "S"
                                          ? "Especial Zircônia!"
                                          : ''),
                                      Container(
                                        child: Icon(
                                            snapshot['especialZirc'] == "S"
                                                ? Icons.star
                                                : null,
                                            color:
                                                snapshot['especialZirc'] == "S"
                                                    ? Colors.blueGrey
                                                    : Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(snapshot['estoque'] == "S"
                                          ? 'Disponível :)'
                                          : 'Esgotada :('),
                                    ],
                                  ),
                                  Text(
                                    snapshot['valorAte'].toString() != null
                                        ? "R\$ " +
                                            snapshot['valorAte'].toString() +
                                            '0'
                                        : '',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                    id: snapshot.documentID,
                                    categoria: snapshot["categoria"],
                                    classe: snapshot["classe"],
                                    descr: snapshot["descr"],
                                    especialZirc: snapshot["especialZirc"],
                                    folheado: snapshot["folheado"],
                                    imag: snapshot["imag"],
                                    qtd: snapshot["qtd"],
                                    ref: snapshot["ref"],
                                    valorAte: snapshot["valorAte"],
                                    valorDe: snapshot["valorDe"],
                                    estoque: snapshot["estoque"],
                                    likes: snapshot["likes"],
                                    data: snapshot["data"],
                                  )));
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
        bottomNavigationBar: SizedBox(
          height: 75,
          child: BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      Container(
                          height: 65,
                          color: isAdultoSelected
                              ? filterColor
                              : Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.person,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isAdultoSelected = true;
                                      isInfantilSelected = false;
                                      fClasse = 'Adulto';
                                    });
                                  }),
                              Text('Adulto')
                            ],
                          )),
                      Container(
                        height: 65,
                        color: isInfantilSelected
                            ? filterColor
                            : Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.child_friendly,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isAdultoSelected = false;
                                    isInfantilSelected = true;
                                    isCouroSelected = false;
                                    fClasse = 'Infantil';
                                  });
                                }),
                            Text('Infantil')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      Container(
                          height: 65,
                          color: isPrataSelected
                              ? filterColor
                              : Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.brightness_1,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      isPrataSelected = true;
                                      isOuroSelected = false;
                                      isCouroSelected = false;
                                      fFolheado = 'Prata';
                                    });
                                  }),
                              Text('Prata')
                            ],
                          )),
                      Container(
                          height: 65,
                          color:
                              isOuroSelected ? filterColor : Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.brightness_1,
                                      color: Colors.orange),
                                  onPressed: () {
                                    setState(() {
                                      isOuroSelected = true;
                                      isPrataSelected = false;
                                      isCouroSelected = false;
                                      fFolheado = 'Dourado';
                                    });
                                  }),
                              Text('Ouro')
                            ],
                          )),
                      Container(
                          height: 65,
                          color: isCouroSelected
                              ? filterColor
                              : Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.brightness_1,
                                      color: Colors.brown),
                                  onPressed: () {
                                    setState(() {
                                      isCouroSelected = true;
                                      isPrataSelected = false;
                                      isOuroSelected = false;
                                      fFolheado = 'Couro';
                                    });
                                  }),
                              Text('Couro')
                            ],
                          )),
                    ],
                  ),
                ),
                Card(
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/002-earrings-4.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Anel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/031-diamond-ring-1.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Brincos",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/024-bracelet.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Pulseiras",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 4,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/009-necklace-2.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Colares",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 5,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/003-box.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Kits",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 6,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/002-earrings-4.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Tornozeleiras",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                              PopupMenuItem(
                                value: 7,
                                child: InkWell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/039-diamond-ring.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            Text(
                                              "Alianças",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ))),
                              ),
                            ],
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  setState(() {
                                    fCategoria = 'Anel';
                                  });
                                  break;
                                case 2:
                                  setState(() {
                                    fCategoria = 'Brinco';
                                  });
                                  break;
                                case 3:
                                  setState(() {
                                    fCategoria = 'Pulseira';
                                  });
                                  break;
                                case 4:
                                  setState(() {
                                    fCategoria = 'Colar';
                                  });
                                  break;
                                case 5:
                                  setState(() {
                                    fCategoria = 'Conjunto';
                                  });
                                  break;
                                case 6:
                                  setState(() {
                                    fCategoria = 'Tornozeleira';
                                  });
                                  break;
                                case 7:
                                  setState(() {
                                    fCategoria = 'Aliança';
                                  });
                                  break;
                              }
                            },
                            child: Container(
                                width: 150,
                                height: 10,
                                child: Icon(Icons.filter_list)),
                          ),
                        ),
                        Text(fCategoria.toString() == 'null'
                            ? 'Selecione a peça aqui :)'
                            : 'Selecionado - $fCategoria')
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
