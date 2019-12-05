import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {


  String id;
  String categoria;
  String classe;
  String descr;
  String especialZirc;
  String folheado;
  String imag;
  int qtd;
  String ref;
  int valorAte;
  int valorDe;
  String estoque;
  int likes;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    categoria = snapshot.data["categoria"];
    classe = snapshot.data["classe"];
    descr = snapshot.data["descr"] + 0.0;
    especialZirc = snapshot.data["especialZirc"];
    folheado = snapshot.data["folheado"];
    imag = snapshot.data["imag"];
    qtd = snapshot.data["qtd"];
    ref = snapshot.data["ref"];
    valorAte = snapshot.data["valorAte"];
    valorDe = snapshot.data["valorDe"];
    estoque = snapshot.data["estoque"];
    likes = snapshot.data["likes"];
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": ref,
      "description": descr,
      "price": valorAte
    };
  }

}