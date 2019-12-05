import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetoflutterv4/datas/likes_products.dart';
import 'package:projetoflutterv4/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class LikeModel extends Model {

  UserModel user;

  List<LikeProduct> products = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  LikeModel(this.user){
    if(user.isLoggedIn())
      _loadLikeItem();
  }

  static LikeModel of(BuildContext context) =>
      ScopedModel.of<LikeModel>(context);


  void addLikeItem(LikeProduct likeProduct){
    products.add(likeProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("likes").add(likeProduct.toMap()).then((doc){
      likeProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeLikeItem(LikeProduct likeProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("likes").document(likeProduct.cid).delete();

    products.remove(likeProduct);

    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();


    DocumentReference refLikes = await Firestore.instance.collection("likes").add(
        {
          "clientId": user.firebaseUser.uid,
          "products": products.map((likeProduct)=>likeProduct.toMap()).toList(),
          "status": 1
        }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("likes").document(refLikes.documentID).setData(
        {
          "orderId": refLikes.documentID
        }
    );

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("likes").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    products.clear();

    isLoading = false;
    notifyListeners();

    return refLikes.documentID;
  }

  void _loadLikeItem() async {

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("likes")
        .getDocuments();

    products = query.documents.map((doc) => LikeProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

}









