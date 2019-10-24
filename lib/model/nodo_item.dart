import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class NoDoItem {
  String itemName;
  String dateCreated;
  String key;

  NoDoItem(this.itemName, this.dateCreated);
  NoDoItem.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      itemName = snapshot.value["itemName"],
      dateCreated = snapshot.value["dateCreated"];

  toJson() {
    return {
      "itemName": itemName,
      "dateCreated": dateCreated
    };
  }
//
//NoDoItem.map(dynamic obj) {
//  this._itemName = obj["itemName"];
//  this._dateCreated = obj["dateCreated"];
//  this._id = obj["id"];
//}
//
//String get itemName => _itemName;
//String get dateCreated => _dateCreated;
//int get id => _id;
//
//Map<String, dynamic> toMap(){
//  var map = new Map<String, dynamic>();
//  map["itemName"] = _itemName;
//  map["dateCreated"] = _dateCreated;
//  if (_id != null) {
//    map["id"] = _id;
//  }
//  return map;
//}
//
//NoDoItem.fromMap(Map<String, dynamic> map) {
//  this._itemName = map["itemName"];
//  this._dateCreated = map["dateCreated"];
//  this._id = map["id"];
//
//}
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: const EdgeInsets.all(8.0),
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(_itemName,
//                style: TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 16.0,
//                ),),
//              Container(
//                margin: const EdgeInsets.all(5.0),
//                child: Text("Created on: $_dateCreated",
//                  style: TextStyle(
//                      color: Colors.black54,
//                      fontSize: 14.5,
//                      fontStyle: FontStyle.italic
//                  ),),
//              )
//            ],
//          ),
//
//
//        ],
//      ),
//    );
//  }
}
