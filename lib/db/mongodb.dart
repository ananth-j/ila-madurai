import 'dart:async';
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import '../logics/jsons/customer_json.dart';

const MAIN_URL_CONNCTION =
    "mongodb+srv://ananth:ananth@ila-sample.z3a5mrs.mongodb.net/?retryWrites=true&w=majority&appName=ila-sample";

class Connector {
  static var db, userCollection, orderCollection;

  static connect() async {
    db = await Db.create(MAIN_URL_CONNCTION);
    await db.open();
    print('connected');
  }

  static createCustomer(
    String name,
    String number,
    String address,
    String deposite,
    String price,
    DateTime joindate,
    int sms,
  ) async {
    String isSms = '';
    if (sms == 1) {
      isSms = 'No';
    } else {
      isSms = 'Yes';
    }
    var res;

    if (name.isNotEmpty &&
        number.isNotEmpty &&
        address.isNotEmpty &&
        deposite.isNotEmpty &&
        price.isNotEmpty) {
      try {
        int _price = int.parse(price);
        CustomerJson obj = CustomerJson(
          name: name,
          address: address,
          deposite: deposite,
          jiondate: joindate, //joindate.toIso8601String(),
          number: number,
          price: _price,
          sms: isSms,
        );
        userCollection = db.collection('customers');
        await userCollection.insertOne(obj.toMap());
        res = 'success';
      } catch (e) {
        res = e.toString();
        print(e.toString());
      }
    } else {
      res = 'faild';
    }

    return res;
  }

  // static dynamic deleteCustomer(docId) async {
  //   try {
  //     userCollection = db.collection('customers');
  //     await userCollection.deleteOne({'_id': docId});
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  static Future<List<Map<String, dynamic>>> getcustomersPriveteOrders(
      id) async {
    var data;
    orderCollection = db.collection('customerOrder');
    data = await orderCollection
        .find(where.eq('cusid', id).sortBy('time', descending: true))
        .toList();
    return data;
  }

  static deleteOrders(id) async {
    var data;
    orderCollection = db.collection('customerOrder');
    data = await orderCollection.remove(where.eq('cusid', id));
    print('success');
  }

  static deleteCustomerProile(docId) async {
    try {
      userCollection = db.collection('customers');
      await userCollection.deleteOne({'_id': docId});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getcustomers() async {
    var data;

    userCollection = db.collection('customers');
    data = await userCollection
        .find(where.sortBy('cusjiondate', descending: true))
        .toList();

    return data;
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    var data;
    try {
      orderCollection = db.collection('orders');
      data = await orderCollection
          .find(where.sortBy('time', descending: true))
          .toList();
      return data;
    } catch (e) {}
    return data;
  }

  static salesLogicsCustomer(id, data) async {
    var orderhistorycol, orderhistorycolForCustomers;
    try {
      userCollection = db.collection('customers');
      final query = where.eq('_id', id);
      final update = modify
          .set('lastorder', data['lastorder'])
          .set('depitmoney', data['depitmoney'])
          .set('holdingcans', data['holdingcans'])
          .set('totalorder', data['totalorder'])
          .set('filledcans', data['filledcans'])
          .set('gededmoney', data['gededmoney'])
          .set('vname', data['vname'])
          .set('cusid', data['cusid'])
          .set('cusname', data['cusname'])
          .set('vid', data['vid'])
          .set('time', DateTime.now())
          .set('getedcans', data['getedcans']);

      await userCollection.update(query, update);
      orderhistorycol = db.collection('orders');
      orderhistorycolForCustomers = db.collection('customerOrder');
      orderhistorycol.insertOne(data);
      orderhistorycolForCustomers.insertOne(data);
    } catch (e) {}
  }
}
