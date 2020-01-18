import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  OrderScreen(this.orderId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SizedBox(
                width: 300,
                height: 300,
                child: FlareActor(
                  'assets/flr/stars.flr',
                  fit: BoxFit.fitWidth,
                  animation: 'estrellas',
                ),
              ),
            ),
            Text(
              "Uhul! Seu pedido foi realizado com sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: FlareActor(
                'assets/flr/check.flr',
                fit: BoxFit.fitWidth,
                animation: 'show',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
