import '../../db/mongodb.dart';
import '../editor_json/customer_edit_json.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:async';
import 'dart:developer';

class CustomerEditLogics {
  static var db, userCollection;

  Future<String> editCustomer(
    String name,
    String number,
    String address,
    String deposite,
    String price,
    DateTime joindate,
    int sms,
    String holdingcanes,
    String totalorder,
    String debitmoney,
    String lastOrder,
    var id,
  ) async {
    // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    int _holdingcanes = 0;
    int _totalorder = 0;
    int _debitmoney = 0;
    int _lastOrder = 0;
    int _price = 0;
    if (price != '') {
      _holdingcanes = int.parse(price);
    }
    if (holdingcanes != '') {
      _holdingcanes = int.parse(holdingcanes);
    }
    if (totalorder != '') {
      _totalorder = int.parse(totalorder);
    }
    if (debitmoney != '') {
      _debitmoney = int.parse(debitmoney);
    }
    if (lastOrder != '') {
      _lastOrder = int.parse(lastOrder);
    }

    String isSms = '';
    if (sms == 1) {
      isSms = 'No';
    } else {
      isSms = 'Yes';
    }
    String res = '';
    if (name.isNotEmpty &&
        number.isNotEmpty &&
        address.isNotEmpty &&
        deposite.isNotEmpty &&
        price.isNotEmpty) {
      try {
        CustomerEditJson obj = CustomerEditJson(
          address: address,
          debitmoney: _debitmoney,
          deposite: deposite,
          holdingcans: _holdingcanes,
          jiondate: joindate,
          lastOrder: _lastOrder,
          name: name,
          totalorder: _totalorder,
          number: number,
          price: price,
          sms: isSms,
        );
        db = await Db.create(MAIN_URL_CONNCTION);
        await db.open();
        userCollection = db.collection('customers');
        final query = where.eq('_id', id);
        await userCollection.update(query, obj.toMap());
        await db.close();
        res = 'success';
      } catch (e) {
        print(e.toString());
        res = e.toString();
      }
    }
    return res;
  }
}
