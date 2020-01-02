import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {

    //TODO: ver sobre cloud functions

    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("1.Recebido", () => 5);
    dataMap.putIfAbsent("2.Transporte", () => 3);
    dataMap.putIfAbsent("3.Entregue", () => 2);

    return Column(
      children: <Widget>[
        StreamBuilder(
            stream: Firestore.instance.collection("orders").document().snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 1.0,
                    child: Container(
                      height: 100,
                      width: 370,
                      child:
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 1000),
                        chartLegendSpacing: 22.0,
                        chartRadius: MediaQuery.of(context).size.width / 2.7,
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        showChartValuesOutside: false,
                        chartValueBackgroundColor: Colors.grey[200],
                        showLegends: true,
                        legendPosition: LegendPosition.right,
                        decimalPlaces: 1,
                        showChartValueLabel: true,
                        initialAngle: 0,
                        chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.blueGrey[900].withOpacity(0.9),
                        ),
                        chartType: ChartType.disc,
                      ),
                    ),
                  ),
                );
              }
            }),
        Card(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection("orders").document(orderId).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else {
                      int status = snapshot.data['status'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            elevation: 1,
                            child: ExpansionTile(
                              title: Text(
                                "Pedido: \n" + orderId.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                              leading: Icon(Icons.info),
                              trailing: Icon(Icons.add),
                              children: <Widget>[
                                Text(_buildProductsText(snapshot.data)),
                                Text(
                                  "Status: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      _buildCircle(
                                          "1", "Pedido Recebido", status, 1),
                                      Opacity(
                                        opacity: 1.0,
                                        child: Image.asset(
                                          'assets/images/order.png',
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1.0,
                                    width: 40.0,
                                    color: Colors.grey[500],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _buildCircle(
                                          "2", "Transporte", status, 2),
                                      Opacity(
                                        opacity: status == 1 ? 0.0 : 1.0,
                                        child: Image.asset(
                                          'assets/images/way.png',
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1.0,
                                    width: 40.0,
                                    color: Colors.grey[500],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _buildCircle("3", "Entregue", status, 3),
                                      Opacity(
                                        opacity: status == 1 ||
                                                status == 2 ||
                                                status == 3
                                            ? 0.0
                                            : 1.0,
                                        child: Image.asset(
                                          'assets/images/truck.png',
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      );
                    }
                  }),
            ))
      ],
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";
    Timestamp _stamp = snapshot.data["date"];
    DateTime _date = _stamp.toDate();
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(_date);
    String formattedDate = formatter.format(_date);

    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
          "${p["qtd"]} x ${p["categoria"]} ${p["folheado"]} (R\$ ${p["valorAte"].toStringAsFixed(2)})\n";
    }
    text +=
        "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}\nRealizado em: " +
            formattedDate +
            " " +
            formattedTime;
    return text;
  }

  Widget _buildCircle(
      final title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}
