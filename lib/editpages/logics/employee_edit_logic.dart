import 'package:cloud_firestore/cloud_firestore.dart';

import '../../logics/jsons/employee_json.dart';
import '../editor_json/employe_edit_json.dart';

class EmployeeEditLogic {
  Future<String> editEmployee(
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
    String docid,
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
        EmployeeEditJson obj = EmployeeEditJson(
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
        );
        await _firestore.collection('employees').doc(docid).set(obj.toJson());
        res = 'success';
      } catch (e) {
        res = e.toString();
      }
    } else {
      res = 'somethig wrong';
    }
    return res;
  }
}
