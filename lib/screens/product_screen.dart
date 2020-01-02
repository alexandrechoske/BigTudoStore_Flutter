import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoflutterv4/datas/cart_product.dart';
import 'package:projetoflutterv4/models/cart_model.dart';
import 'package:projetoflutterv4/models/user_model.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    this.id,
    this.categoria,
    this.classe,
    this.descr,
    this.especialZirc,
    this.folheado,
    this.imag,
    this.qtd,
    this.ref,
    this.valorAte,
    this.valorDe,
    this.estoque,
    this.likes,
    this.data,
    this.references,
  });

  final String id;
  final String categoria;
  final String classe;
  final String descr;
  final String especialZirc;
  final String folheado;
  final String imag;
  final int qtd;
  final String ref;
  final double valorAte;
  final double valorDe;
  final int likes;
  final String estoque;
  final String data;
  final references;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool checkItemCart = false;
  bool checkFavorite = false;
  String favAnimation = '';
  double buttonSize = 20;
  double buttonPadding = 10;

  void fCheckCart() {
    setState(() {
      checkItemCart = true;
    });
  }

  void fCheckFavorite() {
    setState(() {
      checkFavorite = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userLogged = (UserModel.of(context).isLoggedIn())
        ? UserModel.of(context).firebaseUser.uid
        : '';

    final CollectionReference refFav = Firestore.instance
        .collection("favorites")
        .document(widget.ref.toString())
        .collection(userLogged);

    final CollectionReference refLikes = Firestore.instance
        .collection("likes")
        .document('products')
        .collection(widget.ref.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Big Tudo Store'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
                height: 300,
                width: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/gifs/spinner2.gif',
                  image: widget.imag != null ? widget.imag : '',
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {
                      Share.share('Muito Top essa peça, da uma olhada! ' +
                          widget.descr +
                          ' -  \n ' +
                          widget.imag +
                          ' e ela está somente R\$' +
                          widget.valorAte.toString() +
                          '0');
                    },
                    child: new Icon(
                      Icons.share,
                      color: Colors.black,
                      size: buttonSize,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(buttonPadding),
                  ),
                  RawMaterialButton(
                    onPressed: () => launch(widget.imag),
                    child: new Icon(Icons.open_in_browser,
                        color: Colors.black, size: buttonSize),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(buttonPadding),
                  ),
                  StreamBuilder(
                      stream: refFav.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Container();
                        return Column(
                          children: <Widget>[
                            Opacity(
                              opacity: (UserModel.of(context).isLoggedIn())
                                  ? 1.0
                                  : 0.0,
                              child: RawMaterialButton(
                                onPressed: snapshot.data.documents.length == 0
                                    ? () async {
                                        await refFav
                                            .document(userLogged)
                                            .setData({
                                          "prodId": widget.id,
                                          "folheado": widget.folheado,
                                          "user": userLogged,
                                          "categoria": widget.categoria,
                                          "registro": DateTime.now(),
                                        });
                                      }
                                    : () async {
                                        await refFav
                                            .document(userLogged)
                                            .delete();
                                      },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(Icons.favorite,
                                      size: buttonSize,
                                      color: snapshot.data.documents.length == 0
                                          ? Colors.black
                                          : Colors.red),
                                ),
                                shape: CircleBorder(),
                                elevation: 2.0,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }),
                  StreamBuilder(
                      stream: refLikes.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Opacity(
                                  opacity: (UserModel.of(context).isLoggedIn())
                                      ? 1.0
                                      : 0.0,
                                  child: RawMaterialButton(
                                    onPressed:
                                        snapshot.data.documents.length == 0
                                            ? () async {
                                                await refLikes
                                                    .document(userLogged)
                                                    .setData({
                                                  "prodId": widget.id,
                                                  "folheado": widget.folheado,
                                                  "user": userLogged,
                                                  "categoria": widget.categoria,
                                                  "registro": DateTime.now(),
                                                });
                                              }
                                            : () async {
                                                await refLikes
                                                    .document(userLogged)
                                                    .delete();
                                              },
                                    child: Icon(Icons.thumb_up,
                                        size: buttonSize,
                                        color:
                                            snapshot.data.documents.length == 0
                                                ? Colors.black
                                                : Colors.blue),
                                    shape: new CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    padding: EdgeInsets.all(buttonPadding),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.categoria + ' ' + widget.descr,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "R\$ ${widget.valorDe}" + "0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
                Text(
                  "R\$ ${widget.valorAte}" + "0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                Opacity(
                  opacity: (UserModel.of(context).isLoggedIn()) ||
                          widget.estoque == "S"
                      ? 1.0
                      : 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Colors.blue,
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        //`Icon` to display
                        label: Text(
                          UserModel.of(context).isLoggedIn()
                              ? "Adicionar ao Carrinho"
                              : "Entre para Comprar",
                          style: TextStyle(color: Colors.white),
                        ),

                        //`Text` to display
                        onPressed: () {
                          if (UserModel.of(context).isLoggedIn()) {
                            fCheckCart();
                            CartProduct cartProduct = CartProduct();
                            cartProduct.quantity = 1;
                            cartProduct.pid = widget.ref;
                            cartProduct.category = widget.categoria;
                            cartProduct.classe = widget.classe;
                            cartProduct.folheado = widget.folheado;
                            cartProduct.valorAte = widget.valorAte;
                            cartProduct.descr = widget.descr;
                            cartProduct.imag = widget.imag;

                            CartModel.of(context).addCartItem(cartProduct);
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          }
                        },
                      ),
                      Container(
                        child: Opacity(
                          opacity: checkItemCart ? 1.0 : 0.0,
                          child: Text(checkItemCart ? 'Item Adicionado!' : ''),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Opacity(
                          opacity: checkItemCart ? 1.0 : 0.0,
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset('assets/gifs/checkmarkgif.gif'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ExpansionTile(
                      title: Text(
                        "Mais Informações",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                      leading: Icon(Icons.info),
                      trailing: Icon(Icons.info_outline),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Divider(
                                color: Colors.blueAccent,
                                height: 10,
                                thickness: 0.5,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Referência da Peça'),
                                      Text(widget.ref)
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.blueAccent,
                                    height: 10,
                                    thickness: 0.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Classe'),
                                      Text(widget.classe)
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.blueAccent,
                                    height: 10,
                                    thickness: 0.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Categoria'),
                                      Text(widget.categoria)
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.blueAccent,
                                    height: 10,
                                    thickness: 0.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Zircônia'),
                                      Icon(
                                          widget.especialZirc == "S"
                                              ? Icons.check
                                              : null,
                                          color: widget.especialZirc == "S"
                                              ? Colors.green
                                              : Colors.black),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.blueAccent,
                                    height: 10,
                                    thickness: 0.5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Estoque'),
                                      Icon(
                                          widget.estoque == "S"
                                              ? Icons.check
                                              : Icons.fiber_manual_record,
                                          color: widget.estoque == "S"
                                              ? Colors.green
                                              : Colors.red),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
