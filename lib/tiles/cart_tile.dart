import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetoflutterv4/datas/cart_product.dart';
import 'package:projetoflutterv4/datas/product_data.dart';
import 'package:projetoflutterv4/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(8.0),
              width: 120.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  cartProduct.imag,
                  fit: BoxFit.cover,
                ),
              )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Descrição: ${cartProduct.descr}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cartProduct.valorAte.toString()}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cartProduct.quantity > 1
                            ? () {
                                CartModel.of(context).decProduct(cartProduct);
                              }
                            : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cartProduct.category == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("bdralifla")
                    .document(cartProduct.category)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 100.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}