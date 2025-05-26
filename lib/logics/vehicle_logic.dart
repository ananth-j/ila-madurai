import 'package:cloud_firestore/cloud_firestore.dart';

import 'jsons/vehicle_json.dart';

class VehicleLogic {
  Future<String> addVehicle(
    String name,
    String number,
    String chaseNo,
    String engineNo,
    String capacity,
    int fueltype, // if fueltype == 1 : diesel || feultype == 2 : petrol
    DateTime serviceddate,
    DateTime nextservice,
  ) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String fuel;
    String res;
    if (fueltype == 1) {
      fuel = 'Diesel';
    } else {
      fuel = 'Petrol';
    }
    if (name.isNotEmpty &&
        number.isNotEmpty &&
        chaseNo.isNotEmpty &&
        engineNo.isNotEmpty &&
        capacity.isNotEmpty) {
      // Vehilce Json
      try {
        VehicleJson ob = VehicleJson(
            capacity: capacity,
            chaseno: chaseNo,
            engineno: engineNo,
            fueltype: fuel,
            name: name,
            nextservice: nextservice,
            number: number,
            serviceddate: serviceddate);
        await _firestore.collection('vehicles').add(ob.toJson());
        res = 'success';
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'something wrong';
    }
    return res;
  }

  deleteVehicle(String number) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('vehicles').doc(number).delete();
  }
}
