import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logics/vehicle_logic.dart';
import '../res/textfeild.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  TextEditingController vehname = TextEditingController();

  TextEditingController vehnumber = TextEditingController();

  TextEditingController engno = TextEditingController();

  TextEditingController chaseno = TextEditingController();

  TextEditingController capacity = TextEditingController();

  TextEditingController driver = TextEditingController();

  DateTime serviceddate = DateTime.now();
  DateTime nextservice = DateTime.now();
  int fuelselectedValue = 1;
  bool isLoading = false;
  thisaddvehicle() async {
    setState(() {
      isLoading = true;
    });
    String res;
    VehicleLogic obect = VehicleLogic();
    // create vehicle
    res = await obect.addVehicle(
        vehname.text,
        vehnumber.text,
        chaseno.text,
        engno.text,
        capacity.text,
        fuelselectedValue,
        serviceddate,
        nextservice);
        setState(() {
      isLoading = false;
    });
    if (res == 'success') {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 6, 204, 12),
                content: const Text(
                  'New vehicle added successfully',
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
           isLoading ? Center(child: CircularProgressIndicator(),) : Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 224, 224, 224)),
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
                  const Text('Add Vehicle',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 17, 47, 219))),
                  const Spacer(),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      thisaddvehicle();
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
                      controller: vehname,
                      hint: 'Vehicle name',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: vehnumber,
                      hint: 'Vehicle No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: engno,
                      hint: 'Engine No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: chaseno,
                      hint: 'Chase No',
                      keybord: TextInputType.text),
                  const SizedBox(height: 7),
                  TextFeildDub(
                      controller: capacity,
                      hint: 'Capacity',
                      keybord: TextInputType.number),
                  const SizedBox(height: 10),
    
                  // date picker
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Seviced Date   : ${serviceddate.day}:${serviceddate.month}:${serviceddate.year}',
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
                                    initialDateTime: serviceddate,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        serviceddate = newTime;
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Next Service    : ${nextservice.day}:${nextservice.month}:${nextservice.year}',
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
                                    initialDateTime: nextservice,
                                    mode: CupertinoDatePickerMode.date,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (DateTime newTime) {
                                      setState(() {
                                        nextservice = newTime;
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
                  // Fuel Type
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Fuel type : ',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        RadioMenuButton(
                          value: 1,
                          groupValue: fuelselectedValue,
                          onChanged: (value) {
                            setState(() {
                              fuelselectedValue = value!;
                            });
                          },
                          child: const Text('Diesel'),
                        ),
                        Spacer(),
                        RadioMenuButton(
                          value: 2,
                          groupValue: fuelselectedValue,
                          onChanged: (value) {
                            setState(() {
                              fuelselectedValue = value!;
                            });
                          },
                          child: const Text('Petrol'),
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
