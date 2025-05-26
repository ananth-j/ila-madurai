import 'package:cloud_firestore/cloud_firestore.dart';

import 'jsons/employee_json.dart';

class EmployeeLogic {
  Future<String> createEmploy(
    String name,
    String phone,
    String address,
    String age,
    int gender,
    String exprience,
    String salary,
    DateTime joindate,
    String workinghrs,
    String id,
    String desingnation,
  ) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = '';
    String empgender;
    if (gender == 1) {
      empgender = 'Male';
    } else {
      empgender = 'Female';
    }
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        age.isNotEmpty &&
        exprience.isNotEmpty &&
        salary.isNotEmpty) {
      try {
        EmployeeJson obj = EmployeeJson(
          address: address,
          age: age,
          exprience: exprience,
          gender: empgender,
          id: id,
          jiondate: joindate,
          name: name,
          phone: phone,
          salary: salary,
          workinghrs: workinghrs,
          desingnation: desingnation,
        );
        await _firestore.collection('employees').add(obj.toJson());
        res = 'success';
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'somethig wrong';
    }
    return res;
  }

  deleteEmployee(String docId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('employees').doc(docId).delete();
  }
}
