import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../db/mongodb.dart';

import 'jsons/mainScreenSuperLogicJson.dart';

class SalesLogic {
  static var db, userCollection;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Edit the vhecle data on daily sales page Simple EDIT
  mainScreenLogic(todaycollection, fill, empty, String id) async {
    try {
      int _fill = 0;
      int _empty = 0;
      int _todaycollection = 0;
      if (todaycollection != '') {
        _todaycollection = int.parse(todaycollection);
      }
      if (fill != '') {
        _fill = int.parse(fill);
      }
      if (empty != '') {
        _empty = int.parse(empty);
      }
      await _firestore.collection('vehicles').doc(id).update({
        "fill": _fill,
        "empty": _empty,
        "todaycollection": _todaycollection,
        'remainig': _fill,
      });
    } catch (e) {}
  }

  // Edit the vhecle data on daily sales page  (SUPER LOGIC MEANS CHANGE THE VALUE OF FILL , EMPTY , TC whet feild is 0 )
  mainScreenSuperLogic(todaycollection, fill, empty, String id) async {
    try {
      int _fill = 0;
      int _empty = 0;
      int _todaycollection = 0;
      if (todaycollection != '') {
        _todaycollection = int.parse(todaycollection);
      }
      if (fill != '') {
        _fill = int.parse(fill);
      }
      if (empty != '') {
        _empty = int.parse(empty);
      }
      mainScreenSuperLogicJson obj = mainScreenSuperLogicJson(
          empty: _empty, fill: _fill, todaycollection: _todaycollection);
      await _firestore.collection('vehicles').doc(id).update(obj.mainJson());
    } catch (e) {}
  }

 

  // Edit the vehicle data when customer order is cliced
  salesVehicleedit(vid, orderdata, vdaa) async {
    //{lastorder: 390, depitmoney: 90, holdingcans: 10, totalorder: 585, filledcans: 10, gededmoney: 300, getedcans: 4}
    //Order data values
    try {
      var vdata = await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(vid)
          .get();

      print('V ============ ${vdata.toString()}');

      int _gededmoney =
          orderdata['gededmoney'] == null ? 0 : orderdata['gededmoney'];
      int _depitmoney = 0;
      int _lastorder = 0;
      int _filledcans = orderdata['filledcans'];
      int _getedcans = orderdata['getedcans'];
      if (orderdata['lastorder'] != null) {
        _lastorder = orderdata['lastorder'];
      }
      if (orderdata['depitmoney'] != null) {
        _depitmoney = orderdata['depitmoney'];
      }
      // Vehicle data values
      int openfilledcans = 0;
      int openemptycans = 0;
      int remainingcans = 0;
      int _totalcollection = 0;
      int supertotalcollection = 0;
      if (vdata['fill'] != '') {
        openfilledcans = int.parse('${vdata['fill']}');
      }
      if (vdata['empty'] != '') {
        openemptycans = int.parse('${vdata['empty']}');
      }
      if (vdata['remainig'] != '') {
        remainingcans = int.parse('${vdata['remainig']}');
      }
      _totalcollection = vdata['todaycollection'] + _gededmoney;
      supertotalcollection = vdata['totalcollection'] + _gededmoney;

      int closingfilledcans = remainingcans - _filledcans;
      int closingempty = openemptycans + _getedcans;
      if (closingfilledcans < 0) {
        closingfilledcans = 0;
      }

      print(vdata.toString());
      vehicleSalesEditJson obj = vehicleSalesEditJson(
        depitmoney: _depitmoney,
        closingfilledcans: closingfilledcans,
        gededmoney: _gededmoney,
        closingempty: closingempty,
        totalcollection: _totalcollection,
        supertotalcollection: supertotalcollection,
      );
      await _firestore
          .collection('vehicles')
          .doc(vid)
          .update(obj.vehicleEditJson());
    } catch (e) {}
  }
}

class vehicleSalesEditJson {
  final totalcollection;
  final depitmoney;
  final closingfilledcans;
  final gededmoney;
  final closingempty;
  final supertotalcollection;

  vehicleSalesEditJson({
    required this.depitmoney,
    required this.gededmoney,
    required this.closingfilledcans,
    required this.closingempty,
    required this.totalcollection,
    required this.supertotalcollection,
  });
  Map<String, dynamic> vehicleEditJson() => {
        'closingempty': closingempty,
        'todaycollection': totalcollection,
        'closingfill': closingfilledcans,
        'depitmoney': depitmoney,
        'gededmoney': gededmoney,
        'remainig': closingfilledcans,
        'totalcollection': supertotalcollection,
      };
}
