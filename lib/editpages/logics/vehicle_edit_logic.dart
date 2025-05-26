import 'package:cloud_firestore/cloud_firestore.dart';

import '../editor_json/vehicle_edit_json.dart';

class VehicleEditLogic {
  Future<String> editVehicle(
    String name,
    String number,
    String chaseNo,
    String engineNo,
    String capacity,
    int fueltype, // if fueltype == 1 : diesel || feultype == 2 : petrol
    DateTime serviceddate,
    DateTime nextservice,
    String debit,
    String totalcollection,
    String id,
  ) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String fuel;
    String res;
    if (fueltype == 1) {
      fuel = 'Diesel';
    } else {
      fuel = 'Petrol';
    }
    int Xdebit = 0;
    int Xtotalcollection = 0;
    if (debit != '') {
      Xdebit = int.parse('${debit}');
    }
    if (totalcollection != '') {
      Xtotalcollection = int.parse('${totalcollection}');
    }
    if (name.isNotEmpty &&
        number.isNotEmpty &&
        chaseNo.isNotEmpty &&
        engineNo.isNotEmpty &&
        capacity.isNotEmpty) {
      // Vehilce Json
      try {
        VehicleEditJson ob = VehicleEditJson(
            capacity: capacity,
            chaseno: chaseNo,
            engineno: engineNo,
            fueltype: fuel,
            name: name,
            nextservice: nextservice,
            number: number,
            serviceddate: serviceddate,
            totaldebit: Xdebit,
            totalcollection: Xtotalcollection);
        await _firestore.collection('vehicles').doc(id).update(ob.toJson());
        res = 'success';
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'something wrong';
    }
    return res;
  }
}
