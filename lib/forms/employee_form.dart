import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ila/logics/employee_logic.dart';

import '../res/minitextfeild.dart';
import '../res/textfeild.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  TextEditingController empname = TextEditingController();
  TextEditingController empphone = TextEditingController();
  TextEditingController empid = TextEditingController();
  TextEditingController empaddress = TextEditingController();
  TextEditingController empage = TextEditingController();
  TextEditingController empsalary = TextEditingController();
  TextEditingController empexp = TextEditingController();
  TextEditingController empworkinghrs = TextEditingController();
  TextEditingController desingnation = TextEditingController();
  DateTime dateofjion = DateTime.now();
  int gender = 1;
  bool isLoading = false;
  // new employee add
  thisaddNewEmploy() async {
    setState(() {
      isLoading = true;
    });
    String res = '';
    EmployeeLogic obj = EmployeeLogic();
    res = await obj.createEmploy(
      empname.text,
      empphone.text,
      empaddress.text,
      empage.text,
      gender,
      empexp.text,
      empsalary.text,
      dateofjion,
      empworkinghrs.text,
      empid.text,
      desingnation.text,
    );
    setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 6, 204, 12),
                content: const Text(
                  'New employee added successfully',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('ok'))
                ],
              )));
    } else {
      showDialog(
          context: context,
          builder: ((context) => const AlertDialog(
                backgroundColor: Color.fromARGB(255, 233, 22, 7),
                content: Text(
                  'Something Wrong',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 224, 224, 224)),
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        const Text('Add employ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 17, 47, 219))),
                        const Spacer(),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            thisaddNewEmploy();
                          },
                          icon: const Icon(Icons.check, color: Colors.green),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFeildDub(
                      controller: empname,
                      hint: 'Employee name',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: empphone,
                      hint: 'phone',
                      keybord: TextInputType.number),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: desingnation,
                      hint: 'designation',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: empaddress,
                      hint: 'address',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      MiniTextFeild(
                        controller: empworkinghrs,
                        hint: 'working hrs',
                        width: 80,
                        keybord: TextInputType.number,
                      ),
                      const Spacer(flex: 1),
                      MiniTextFeild(
                        controller: empsalary,
                        hint: 'salary',
                        width: 80,
                        keybord: TextInputType.number,
                      ),
                      const Spacer(flex: 1),
                      MiniTextFeild(
                        controller: empid,
                        hint: 'Id',
                        width: 80,
                        keybord: TextInputType.number,
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      MiniTextFeild(
                        controller: empage,
                        hint: 'age',
                        width: 50,
                        keybord: TextInputType.number,
                      ),
                      const Spacer(flex: 1),
                      MiniTextFeild(
                        controller: empexp,
                        hint: 'exprience',
                        width: 90,
                        keybord: TextInputType.number,
                      ),
                      const Spacer(flex: 8),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // date picker
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Join Date : ${dateofjion.day}:${dateofjion.month}:${dateofjion.year}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: ((context) => SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    maximumDate: DateTime(2040),
                                    minimumDate: DateTime(2020),
                                    initialDateTime: dateofjion,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        dateofjion = newTime;
                                      });
                                    },
                                  ),
                                )),
                          );
                        },
                        child: const Text('Edit date'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RadioMenuButton(
                          value: 1,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                          child: const Text('Male'),
                        ),
                        RadioMenuButton(
                          value: 2,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                          child: const Text('Female'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
