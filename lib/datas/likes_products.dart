import 'package:cloud_firestore/cloud_firestore.dart';

class LikeProduct {

  String cid;
  String category;
  String classe;
  String folheado;
  String descr;
  String imag;
  String pid;
  int quantity;
  double valorAte;
  String size;

  LikeProduct();

  LikeProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["categoria"];
    classe = document.data["classe"];
    folheado = document.data["folheado"];
    pid = document.data["ref"];
    quantity = document.data["qtd"];
    valorAte = document.data["valorAte"];
    descr = document.data["descr"];
    imag = document.data["imag"];
  }

  get productData => null;


  Map<String, dynamic> toMap(){
    return {
      "categoria": category,
      "classe": classe,
      "folheado": folheado,
      "ref": pid,
      "qtd": quantity,
      "valorAte": valorAte,
      "descr": descr,
      "imag": imag,
    };
  }

}